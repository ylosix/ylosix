#!/bin/bash
APP_PATH=/var/www

#Create vagrant user
if ! grep -q vagrant "/etc/group"; then
  su -c "groupadd vagrant"
fi

if ! grep -q vagrant "/etc/passwd"; then
  su -c "useradd -m -g users -s /bin/bash vagrant"
fi

#TODO check if exist
su -c "adduser vagrant vagrant"

if ! grep -q vagrant "/etc/sudoers"; then
  su -c "echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers"
fi

su -c "mkdir -p /home/vagrant/pids"
su -c "mkdir -p /home/vagrant/logs"
su -c "chown -R vagrant:vagrant /home/vagrant"
su -c "chmod -R 0774 /home/vagrant"


