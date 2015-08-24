#!/bin/bash

bundle install --without development test profile --deployment
bundle exec rake db:create
bundle exec rake assets:precompile db:migrate
bundle exec puma -C config/puma.rb
