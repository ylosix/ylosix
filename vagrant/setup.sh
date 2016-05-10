#!/bin/bash

# Stop and remove any existing containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# Run postgres container
docker run -d -p 5432:5432 -v /vagrant:/vagrant -e "POSTGRES_PASSWORD=postgres" --name postgres postgres:9.4.1

# install required packages
sudo apt-get update
sudo apt-get install -qy git
sudo apt-get -qy install nodejs
sudo apt-get install -qy imagemagick
#sudo gem install mailcatcher
sudo apt-get install -qy libpq-dev   # dependency for pg gem
# optional install psql client for Database testing
#sudo apt-get install -qy postgresql-client

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

# TODO Set the working environment
#export RAILS_ENV=development
#export DATABASE_URL=postgres://postgres:postgres@127.0.0.1:5432/ecommerce
#./set_env_var.sh

# generate database
cd /vagrant
bundle install
bundle exec rake db:create db:schema:load db:gen_demo
#bundle exec rake db:migrate
