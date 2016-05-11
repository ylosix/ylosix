#!/bin/bash

# install new gems and make new migrations
cd /vagrant
bundle install
bundle exec rake db:migrate

# Commands required to ensure correct docker containers are started when the vm is rebooted.
docker start postgres

#mailcatcher --ip 0.0.0.0
