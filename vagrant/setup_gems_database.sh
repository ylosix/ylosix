#!/bin/bash

# To start using RVM you need to run `source /home/vagrant/.rvm/scripts/rvm`
# in all your open shell windows, in rare cases you need to reopen all shell windows.
source /home/vagrant/.rvm/scripts/rvm
rm -rf /usr/local/bundle/config

gem update --system
rvm gemset use global
gem update
# disable gem documentation install to speed up gem installation
echo "gem: --no-document" >> ~/.gemrc
echo "gem: --no-rdoc --no-ri" >> ~/.gemrc
gem install bundler

#create and use a developmet gemset
rvm use ruby-2.3.0@development --create
rvm --default use ruby-2.3.0@development

# Set the working environment
export RAILS_ENV=development
export DATABASE_URL=postgres://postgres:postgres@127.0.0.1:5432/ecommerce
./set_env_var.sh

# generate database
cd /vagrant
bundle install
bundle exec rake db:create db:schema:load db:gen_demo
#bundle exec rake db:migrate
