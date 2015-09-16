#!/bin/bash
APP_PATH=/var/www

#Create vagrant user
if ! grep -q vagrant "/etc/group"; then
  su -c "groupadd vagrant"
fi

if ! grep -q vagrant "/etc/passwd"; then
  su -c "useradd -m -g users -s /bin/bash vagrant"
fi

if ! grep -q www-data "/etc/group"; then
  su -c "groupadd www-data"
fi

#TODO check if exist
su -c "adduser vagrant vagrant"
su -c "adduser vagrant www-data"

if ! grep -q vagrant "/etc/sudoers"; then
  su -c "echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers"
fi

su -c "mkdir -p /home/vagrant/pids"
su -c "mkdir -p /home/vagrant/logs"
su -c "chown -R vagrant:vagrant /home/vagrant"
su -c "chmod -R 0774 /home/vagrant"

# Add keys for rvm.
# timeout => su -c "gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3"
su -c "gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys D39DC0E3"


