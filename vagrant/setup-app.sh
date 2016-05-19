#!/bin/bash

#set environment variables
source ~/.profile && [ -z "$DATABASE_URL" ] && echo "export DATABASE_URL=postgres://postgres:postgres@127.0.0.1:5432/ecommerce" >> ~/.profile
source ~/.profile && [ -z "$RAILS_ENV" ] && echo "export RAILS_ENV=development" >> ~/.profile

# generate database
cd /vagrant; bundle install
cd /vagrant; bundle exec rake db:create db:schema:load db:gen_demo
