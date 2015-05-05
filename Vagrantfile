# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty32'
  config.vm.hostname = 'ecommerce-vm'

  config.vm.network 'forwarded_port', guest: 80, host: 13000 # Rails app
  config.vm.synced_folder '.', '/var/www'

  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.memory = '1024'
  end

  config.vm.provider :digital_ocean do |provider, override|
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    override.vm.box = 'digital_ocean'
    override.vm.box_url = 'https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box'

    provider.token = 'YOUR_TOKEN'
    provider.image = 'ubuntu-14-04-x64'
    provider.region = 'lon1'
    provider.size = '1gb'
  end

  # install puppet provisioner for digital ocean provider
  config.vm.provision 'shell', inline: 'apt-get install -y puppet'

  config.vm.provision :puppet do |puppet|
    puppet.facter = {
        'RAILS_ENV' => ENV['RAILS_ENV']
    }

    puppet.manifests_path = 'puppet/manifests'
    puppet.module_path = 'puppet/modules'
  end

  config.vm.provision 'shell', path: 'puppet/scripts/vagrant-init.sh', :args => ENV['RAILS_ENV']

  config.trigger.after :up do
    run "vagrant ssh -c 'sudo service unicorn start'"
  end
end
