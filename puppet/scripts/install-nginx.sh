#!/bin/bash
APP_PATH=/var/www

#Install nginx
su -c "apt-get install -qq -y nginx --force-yes"
su -c "rm /etc/nginx/sites-enabled/default"

#TODO Check if contains daemon off already.
su -c "echo 'daemon off;' >> /etc/nginx/nginx.conf"
su -c "service nginx stop"
su -c "ln -s '$APP_PATH/puppet/nginx-default.conf' /etc/nginx/conf.d/default.conf"
su -c "ln -s '$APP_PATH/config/unicorn_init.sh' /etc/init.d/unicorn"
su -c "chown -R www-data:www-data /var/log/nginx"
su -c "chmod -R 775 /var/log/nginx"

su -c "adduser vagrant www-data"
su -c "chown www-data:www-data -R $APP_PATH"
su -c "chmod 775 $APP_PATH"
su -c "chmod -R g+w $APP_PATH"