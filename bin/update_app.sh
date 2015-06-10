#!/usr/bin/env bash

git fetch origin;
git pull origin;

bundle install --without development test profile

rake RAILS_ENV=production update_app

chown -R www-data:www-data /var/www/public
chmod -R g+w /var/www/public