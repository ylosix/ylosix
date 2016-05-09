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
