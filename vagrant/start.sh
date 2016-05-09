#!/bin/bash

# Set the working environment
export RAILS_ENV=development
export DATABASE_URL=postgres://postgres:postgres@127.0.0.1:5432/ecommerce
rvm ruby-2.3.0@development

# Commands required to ensure correct docker containers are started when the vm is rebooted.
docker start postgres

#mailcatcher --ip 0.0.0.0
