#!/bin/bash

# Stop and remove any existing containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# Run postgres container
docker run -d -p 5432:5432 -v /vagrant:/vagrant -e "POSTGRES_PASSWORD=postgres" --name postgres postgres:9.4.1

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
