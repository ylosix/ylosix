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

    # Setup project dependencies and postgres container
    app.vm.provision 'shell', path: 'vagrant/setup.sh'
    # install RVM
    config.vm.provision :shell, path: "vagrant/install-rvm.sh", args: "stable", privileged: false
    # install Ruby
    config.vm.provision :shell, path: "vagrant/install-ruby.sh", args: "2.3.0 rails bundler", privileged: false
    # Install gems and generate Dababase
    app.vm.provision 'shell', path: 'vagrant/setup_gems_database.sh', privileged: false
    #set environment variables
    config.vm.provision 'shell', run: 'always', path: "vagrant/set_env_var.sh", privileged: false
    # Launch app
    app.vm.provision 'shell', run: 'always', path: 'vagrant/start.sh', privileged: false

  end
end
