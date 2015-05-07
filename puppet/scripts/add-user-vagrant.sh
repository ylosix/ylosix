#!/bin/bash
APP_PATH=/var/www

#Create vagrant user
su -c "groupadd vagrant"
su -c "useradd -m -g users -s /bin/bash vagrant"
su -c "adduser vagrant vagrant"

#TODO check if exist
su -c "echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers"

su -c "mkdir -p /home/vagrant/pids"
su -c "mkdir -p /home/vagrant/logs"
su -c "chown -R vagrant:vagrant /home/vagrant"
su -c "chmod -R 0774 /home/vagrant"


