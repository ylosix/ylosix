#!/bin/bash

rm -rf /usr/local/bundle/config
bundle install
bundle exec rake db:create db:schema:load db:gen_demo
echo "1" > ./tmp/container_prepared
