#!/bin/bash

# Stop and remove any existing containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# Removed if already prepared
rm -rf ./tmp/container_prepared

# Run postgres container
docker run -d -p 5432:5432 -v /vagrant:/vagrant -e "POSTGRES_PASSWORD=postgres" --name postgres postgres:9.4.1

#docker run -d -p 3000:3000 -v /vagrant:/var/www --privileged --link postgres:db \
#        -e "RAILS_ENV=development" \
#        -e "DATABASE_URL=postgres://postgres:postgres@db:5432/ecommerce" \
#        --name rails ylosix/ylosix ./vagrant/start_container.sh
#docker exec rails ./vagrant/prepare_container.sh

# install required packages
sudo apt-get update
sudo apt-get install -qy curl
sudo apt-get install -qy git
sudo apt-get -qy install nodejs
sudo apt-get install -qy imagemagick
#sudo gem install mailcatcher
sudo apt-get install -qy libpq-dev   # dependency for pg gem
# optional install psql client for Database testing
#sudo apt-get install -qy postgresql-client

#******************************************
# setup_gems_database.sh
# To start using RVM you need to run `source /home/vagrant/.rvm/scripts/rvm`
# in all your open shell windows, in rare cases you need to reopen all shell windows.
#source /home/vagrant/.rvm/scripts/rvm

#gem update --system
#rvm gemset use global
#gem update
# disable gem documentation install to speed up gem installation
#echo "gem: --no-document" >> ~/.gemrc
#echo "gem: --no-rdoc --no-ri" >> ~/.gemrc
#gem install bundler

#create and use a developmet gemset
#rvm use ruby-2.3.0@development --create
