#!/bin/bash

# Set the working environment
export RAILS_ENV=development
export DATABASE_URL=postgres://postgres:postgres@127.0.0.1:5432/ecommerce
./set_env_var.sh

# install new gems and make new migrations
cd /vagrant
bundle install
bundle exec rake db:migrate

# Commands required to ensure correct docker containers are started when the vm is rebooted.
docker start postgres

#mailcatcher --ip 0.0.0.0
