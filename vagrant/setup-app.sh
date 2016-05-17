#!/bin/bash

echo "********* setup-app.sh ************"
#sudo -H -u vagrant bash -c 'echo "PATH = $PATH"'

#gem install bundler
#sudo -H -u vagrant bash -c 'gem install bundler'

# generate database
#sudo -H -u vagrant bash -c 'PATH=$PATH:/home/vagrant/.rvm/gems/ruby-2.3.0@global/bin; echo $PATH; cd /vagrant; bundle install; bundle exec rake db:create db:schema:load db:gen_demo'
cd /vagrant; bundle install; bundle exec rake db:create db:schema:load db:gen_demo
