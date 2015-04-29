# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty32"
  config.vm.hostname = "ecommerce-vm"

  config.vm.network "forwarded_port", guest: 3000, host: 13000 # Rails app
  config.vm.synced_folder ".", "/var/www"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "1024"
  end
end
