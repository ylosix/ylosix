#!/bin/bash
APP_PATH=/var/www
RVM_PATH=/usr/local/rvm/wrappers/ruby-2.1.0@ecommerce
RAILS_ENV=$1

if [ -z $RAILS_ENV ]; then
  RAILS_ENV=development
fi


#Create vagrant user
su -c "groupadd vagrant"
su -c "useradd vagrant -g vagrant"
su -c "adduser vagrant www-data"
su -c "mkdir -p /home/vagrant/pids"
su -c "mkdir -p /home/vagrant/logs"
su -c "chown -R vagrant:vagrant /home/vagrant"
su -c "chmod -R 0774 /home/vagrant"
su -c "chown vagrant:vagrant -R /var/www"


#Create environment
su - vagrant -c "cd $APP_PATH; echo \"2.1.0\" > .ruby-version"
su - vagrant -c "cd $APP_PATH; echo \"ecommerce\" > .ruby-gemset"
su - vagrant -c "cd $APP_PATH; echo $RAILS_ENV > .ruby-env"
su - vagrant -c "cd $APP_PATH; echo 'RAILS_ENV=$RAILS_ENV' > .env"

su - vagrant -c "echo 'export RAILS_ENV=$RAILS_ENV;' >> /home/vagrant/.bash_profile"
su - vagrant -c "chmod +x /home/vagrant/.bash_profile"

if [ -z $SECRET_KEY_BASE ]; then
  su - vagrant -c "cd $APP_PATH; $RVM_PATH/rake secret > .ruby-secret"
  SECRET_KEY_BASE=`cat $APP_PATH/.ruby-secret`
  su - vagrant -c "echo 'export SECRET_KEY_BASE=$SECRET_KEY_BASE;' >> /home/vagrant/.bash_profile"
fi


#Setup project
su - vagrant -c "cd $APP_PATH; $RVM_PATH/gem install bundler"
su - vagrant -c "cd $APP_PATH; $RVM_PATH/bundle install"
su - vagrant -c "cd $APP_PATH; $RVM_PATH/rake db:create RAILS_ENV=$RAILS_ENV"
su - vagrant -c "cd $APP_PATH; $RVM_PATH/rake db:migrate RAILS_ENV=$RAILS_ENV"

if [ "$RAILS_ENV" == "production" ]; then
  su - vagrant -c "cd $APP_PATH; $RVM_PATH/rake assets:precompile RAILS_ENV=$RAILS_ENV"
fi

su - vagrant -c "cd $APP_PATH; $RVM_PATH/rake db:seed RAILS_ENV=$RAILS_ENV"


#Install nginx
su -c "apt-get install -y nginx"
su -c "rm /etc/nginx/sites-enabled/default"
su -c "echo 'daemon off;' >> /etc/nginx/nginx.conf"
su -c "service nginx stop"
su -c "ln -s '$APP_PATH/puppet/nginx-default.conf' /etc/nginx/conf.d/default.conf"
su -c "ln -s '$APP_PATH/config/unicorn_init.sh' /etc/init.d/unicorn"
su -c "chown -R www-data:www-data /var/log/nginx"
su -c "chmod -R 775 /var/log/nginx"


#Set foreman file
su - vagrant -c "echo 'web: /usr/local/rvm/wrappers/ruby-2.1.0@ecommerce/bundle exec unicorn -c config/unicorn.rb -E $RAILS_ENV' > $APP_PATH/Procfile"
su - vagrant -c "echo 'nginx: /usr/sbin/nginx -c /etc/nginx/nginx.conf' >> $APP_PATH/Procfile"

su - vagrant -c "cd $APP_PATH; rvmsudo foreman export upstart --app=ecommerce --user=root /etc/init"
su - vagrant -c "cd $APP_PATH; rvmsudo foreman start -f Procfile &"
#su -c "update-rc.d unicorn defaults 89"
#su -c "service unicorn start"
