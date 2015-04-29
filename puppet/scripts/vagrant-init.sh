#!/bin/bash
APP_PATH=/var/www
RVM_PATH=/usr/local/rvm/wrappers/ruby-2.1.0@ecommerce

su - vagrant -c "mkdir /home/vagrant/pids"

su - vagrant -c "cd $APP_PATH; echo \"2.1.0\" > .ruby-version"
su - vagrant -c "cd $APP_PATH; echo \"ecommerce\" > .ruby-gemset"

su - vagrant -c "cd $APP_PATH; $RVM_PATH/gem install bundler"
su - vagrant -c "cd $APP_PATH; $RVM_PATH/bundle install"
su - vagrant -c "cd $APP_PATH; $RVM_PATH/rake db:create"
su - vagrant -c "cd $APP_PATH; $RVM_PATH/rake db:migrate"
su - vagrant -c "cd $APP_PATH; $RVM_PATH/rake db:fixtures:load RAILS_ENV=development"

sudo apt-get install -y nginx
sudo rm /etc/nginx/sites-enabled/default
sudo ln -s "$APP_PATH/puppet/nginx-default.conf" /etc/nginx/conf.d/default.conf
sudo ln -s "$APP_PATH/config/unicorn_init.sh" /etc/init.d/unicorn
sudo update-rc.d unicorn defaults 89
sudo service unicorn start
