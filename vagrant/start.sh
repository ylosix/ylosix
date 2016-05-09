#!/bin/bash

# Commands required to ensure correct docker containers are started when the vm is rebooted.
docker start postgres

#mailcatcher --ip 0.0.0.0

# Set the working environment
export RAILS_ENV=development
export DATABASE_URL=postgres://postgres:postgres@127.0.0.1:5432/ecommerce
rvm ruby-2.3.0@development

rm -rf /usr/local/bundle/config

# generate database
cd /vagrant
bundle install
bundle exec rake db:create db:schema:load db:gen_demo
bundle exec rake db:migrate
#bundle exec puma -C config/puma.rb
