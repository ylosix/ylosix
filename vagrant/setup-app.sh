#!/bin/bash

# generate database
cd /vagrant; bundle install
cd /vagrant; bundle exec rake db:create db:schema:load db:gen_demo
