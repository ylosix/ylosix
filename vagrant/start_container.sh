#!/bin/bash

while [ ! -f ./tmp/container_prepared ]; do sleep 10; done
echo "Starting container!"
bundle install
bundle exec rake db:migrate
bundle exec puma -C config/puma.rb
