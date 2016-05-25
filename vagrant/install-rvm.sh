#!/usr/bin/env bash

#install RVM
#gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
gpg --keyserver hkp://pgp.mit.edu --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  # If the keyservers above return timeouts, use the following alternative
  # curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -L https://get.rvm.io | bash -s stable --ruby

# To start using RVM you need to run `source /home/vagrant/.rvm/scripts/rvm`
# in all your open shell windows, in rare cases you need to reopen all shell windows.
source /home/vagrant/.rvm/scripts/rvm
