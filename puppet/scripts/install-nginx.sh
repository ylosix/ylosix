#!/bin/bash
APP_PATH=/var/www

#Install nginx
su -c "apt-get install -qq -y nginx --force-yes"
su -c "rm /etc/nginx/sites-enabled/default"

if ! grep -q "daemon off;" "/etc/nginx/nginx.conf"; then
  su -c "echo 'daemon off;' >> /etc/nginx/nginx.conf"
fi

su -c "service nginx stop"
#TODO Check if file exist
su -c "ln -s '$APP_PATH/puppet/nginx-default.conf' /etc/nginx/conf.d/default.conf"
su -c "chown -R www-data:www-data /var/log/nginx"

su -c "chmod -R 775 /var/log/nginx"