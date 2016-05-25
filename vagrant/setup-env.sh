#!/bin/bash

# Stop and remove any existing containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# Run postgres container
docker run -d -p 5432:5432 -v /vagrant:/vagrant -e "POSTGRES_PASSWORD=postgres" --name postgres postgres:9.4.1

# install required packages
sudo apt-get update
sudo apt-get install -qy git nodejs imagemagick libpq-dev postgresql-client

