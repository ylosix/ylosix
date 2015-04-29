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

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = 'puppet/modules'
  end

  config.vm.provision "shell", path: "puppet/scripts/vagrant-init.sh"

  config.trigger.after :up do
    run "vagrant ssh -c 'sudo service unicorn start'"
  end
end
