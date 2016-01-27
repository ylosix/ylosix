#!/bin/bash

# Commands required to setup working docker environment, link containers etc.
sudo apt-get update
sudo apt-get install -qy ruby1.9.1-dev build-essential sqlite3 libsqlite3-dev
sudo gem install mailcatcher

# Stop and remove any existing containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# Run and link the containers
docker run -d -p 5432:5432 -v /vagrant:/vagrant -e "POSTGRES_PASSWORD=postgres" --name postgres postgres:9.4.1
docker run -d -p 3000:3000 -v /vagrant:/var/www --privileged --link postgres:db \
        -e "RAILS_ENV=development" \
        -e "DATABASE_URL=postgres://postgres:postgres@db:5432/ecommerce" \
        --name rails ylosix/ylosix ./vagrant/start_container.sh

docker exec rails ./vagrant/prepare_container.sh
