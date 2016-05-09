# -*- mode: ruby -*-
# vi: set ft=ruby :
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'
ENV['RAILS_ENV'] = 'development' if ENV['RAILS_ENV'].nil? || ENV['RAILS_ENV'] == ''
#TODO add default RUBY version

puts "##### Environment => #{ENV['RAILS_ENV']}"

Vagrant.configure(2) do |config|
  config.vm.define 'main_app' do |app|
    # Setup resource requirements
    app.vm.provider 'virtualbox' do |vb|
      vb.gui = false
      vb.memory = 2048
      vb.cpus = 2
    end

    app.vm.network 'forwarded_port', guest: 1080, host: 11080 # Mailcatcher
    app.vm.network 'forwarded_port', guest: 3000, host: 13000 # Rails app
    app.vm.network 'forwarded_port', guest: 5432, host: 15432 # Postgresql

    app.vm.hostname = 'ylosix-vm'

    # Ubuntu
    app.vm.box = 'box-cutter/ubuntu1404-docker'

    # Setup postgres container
    app.vm.provision 'shell', path: 'vagrant/setup.sh'

    # Make sure the correct containers are running
    # every time we start the VM.
    app.vm.provision 'shell', run: 'always', path: 'vagrant/start.sh'

    #set environment variables
    config.vm.provision 'shell', path: "vagrant/set_env_var.sh"

    # install RVM
    config.vm.provision :shell, path: "vagrant/install-rvm.sh", privileged: false

    # launch rails app
    app.vm.provision 'shell', path: 'vagrant/launch_rails_app.sh'

  end
end
