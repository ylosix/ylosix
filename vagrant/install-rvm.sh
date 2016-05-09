#!/usr/bin/env bash

# install required packages
sudo apt-get update
sudo apt-get install -qy curl
sudo apt-get install -qy git
sudo apt-get -qy install nodejs
sudo apt-get install -qy imagemagick
#sudo gem install mailcatcher
sudo apt-get install -qy libpq-dev   # neded dependency for pg gem
# optional install psql client for Database testing
#sudo apt-get install -qy postgresql-client

#install RVM
#gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -L https://get.rvm.io | bash -s stable --ruby
 # To start using RVM you need to run `source /home/vagrant/.rvm/scripts/rvm`
 # in all your open shell windows, in rare cases you need to reopen all shell windows.
source /home/vagrant/.rvm/scripts/rvm

gem update --system
rvm gemset use global
gem update
# disable gem documentation install to speed up gem installation
echo "gem: --no-document" >> ~/.gemrc
echo "gem: --no-rdoc --no-ri" >> ~/.gemrc
gem install bundler

#create and use a developmet gemset
rvm use ruby-2.3.0@development --create
#rvm cleanup all
