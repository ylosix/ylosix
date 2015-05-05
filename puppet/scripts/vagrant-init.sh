#!/bin/bash
APP_PATH=/var/www
RVM_PATH=/usr/local/rvm/wrappers/ruby-2.1.0@ecommerce
RAILS_ENV=$1

if [ -z $RAILS_ENV ]; then
  RAILS_ENV=development
fi

sudo su -c "groupadd vagrant"
sudo su -c "useradd vagrant -g vagrant"
sudo su -c "mkdir -p /home/vagrant/pids"
sudo su -c "mkdir -p /home/vagrant/logs"
sudo su -c "chown -R vagrant:vagrant /home/vagrant"
sudo su -c "chmod -R 0774 /home/vagrant"

sudo su -c "chown vagrant:vagrant -R /var/www"

su - vagrant -c "cd $APP_PATH; echo \"2.1.0\" > .ruby-version"
su - vagrant -c "cd $APP_PATH; echo \"ecommerce\" > .ruby-gemset"
su - vagrant -c "cd $APP_PATH; echo $RAILS_ENV > .ruby-env"

su - vagrant -c "cd $APP_PATH; $RVM_PATH/gem install bundler"
su - vagrant -c "cd $APP_PATH; $RVM_PATH/bundle install"

if [ -z $SECRET_KEY_BASE ]; then
  su - vagrant -c "cd $APP_PATH; $RVM_PATH/rake secret > .ruby-secret"
  SECRET_KEY_BASE=`cat $APP_PATH/.ruby-secret`
  su - vagrant -c "echo 'export SECRET_KEY_BASE=$SECRET_KEY_BASE' >> /home/vagrant/.bash_profile"
  su - vagrant -c "chmod +x /home/vagrant/.bash_profile"
fi

su - vagrant -c "cd $APP_PATH; $RVM_PATH/rake db:create RAILS_ENV=$RAILS_ENV"
su - vagrant -c "cd $APP_PATH; $RVM_PATH/rake db:migrate RAILS_ENV=$RAILS_ENV"

if [ "$RAILS_ENV" == "production" ]; then
  su - vagrant -c "cd $APP_PATH; $RVM_PATH/rake assets:precompile RAILS_ENV=$RAILS_ENV"
fi

su - vagrant -c "cd $APP_PATH; $RVM_PATH/rake db:seed RAILS_ENV=$RAILS_ENV"

sudo apt-get install -y nginx
sudo rm /etc/nginx/sites-enabled/default
sudo ln -s "$APP_PATH/puppet/nginx-default.conf" /etc/nginx/conf.d/default.conf
sudo ln -s "$APP_PATH/config/unicorn_init.sh" /etc/init.d/unicorn
sudo update-rc.d unicorn defaults 89
sudo service unicorn start
