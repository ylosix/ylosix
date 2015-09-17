# Ylosix [![Build Status](https://travis-ci.org/ylosix/ylosix.svg?branch=develop)](https://travis-ci.org/ylosix/ylosix) [![Coverage Status](https://coveralls.io/repos/ylosix/ylosix/badge.svg?branch=develop)](https://coveralls.io/r/ylosix/ylosix?branch=develop) [![Code Climate](https://codeclimate.com/github/ylosix/ylosix/badges/gpa.svg)](https://codeclimate.com/github/ylosix/ylosix) [![security](https://hakiri.io/github/ylosix/ylosix/develop.svg)](https://hakiri.io/github/ylosix/ylosix)


`Ylosix` is a new free and open source e-commerce and CMS solution written in Ruby on Rails. It is designed to be highly scalable, easily customizable, and allow plug-and-play modules to provide new features and integrations with other services.

This repository contains the source for the latest version of Ylosix as well as older releases.

### Demo
- [Frontend](http://ylos.ylosix.com)
- [Backoffice](http://ylos.ylosix.com/admin) (email: `admin@example.com`, password: `password`)


## Table of contents

  * [Installation](#installation)
  * [Deploy at production environments](#deploy-at-production-environments)
  * [Testing](#testing)
  * [Dependencies](#dependencies)
  * [Collaboration](#collaboration)
  * [License](#license)


## Installation

The easiest way to install Ylosix either locally, on your managed server, or on the cloud, is to cloning this repository and using Vagrant to deploy it with all its dependencies.

Follow the next instructions to install Ylosix.

Install `git` and clone the repository. Note the `--recursive` parameter to also download git submodules.

```
$ git clone --recursive https://github.com/ylosix/ylosix.git
```

[Download and install Vagrant](http://www.vagrantup.com/downloads.html) from their website according your OS.

Install the `vagrant-triggers` plugin.

```
$ vagrant plugin install vagrant-triggers
```

Now, depending on your target environment you will have to use a different Vagrant provider. Currently we support Virtualbox, DigitalOcean, Heroku.

#### Virtualbox (local installation for testing/development)

If you don't have it already, [download and install Virtualbox and the Extension Pack](https://www.virtualbox.org/wiki/Downloads).

Create the guest machine and provision it.

```
$ vagrant up main_app
```

The first time you run `vagrant up` will take more time because it will need to download the base image and install the required dependencies in the virtual machine. Next runs will be much quicker.

Once it is done, you will already have a working environment. Ylosix will be running at your local port 13000:

- Store front: [http://localhost:13000](http://localhost:13000)
- Backoffice: [http://localhost:13000/admin](http://localhost:13000/admin)

PostgreSQL configuration:

- Port: `15432`
- Database: `ecommerce`
- User: `ecommerce_user`
- Password: `ecommerce_pass`


#### DigitalOcean

Install the `vagrant-digitalocean` package.

```
$ vagrant plugin install vagrant-digitalocean
```

[Generate an API token](https://cloud.digitalocean.com/settings/applications) and replace the `YOUR_TOKEN` string by yours in the `Vagrantfile`. You can also configure other parameters such as the region or the Droplet size.

```
  config.vm.provider :digital_ocean do |provider, override|
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    override.vm.box = 'digital_ocean'
    override.vm.box_url = 'https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box'

    provider.token = 'YOUR_TOKEN'
    provider.image = 'ubuntu-14-04-x64'
    provider.region = 'nyc2'
    provider.size = '512mb'
  end
```

Create the Droplet and install Ylosix:

```
$ RAILS_ENV=production vagrant up main_app --provider=digital_ocean
```

Once it is done, you will have a production-ready environment in your DigitalOcean Droplet.


#### Heroku

Install [Heroku CLI](https://toolbelt.heroku.com) from the official website.

Run the following commands to create a Heroku dyno and install Ylosix.

```
$ heroku login
$ heroku create
$ heroku addons:add heroku-postgresql:hobby-dev
$ heroku config:set RAILS_DB=postgresql
$ git push heroku master:master
$ heroku run rake db:migrate RAILS_ENV=production
$ heroku run rake db:gen_demo
```


#### Managed server

You can also install Ylosix in your managed server. Just edit the `Vagrantfile` and configure your SSH credentials.

```
  app.vm.provider :managed do |provider, override|
    override.ssh.username = 'username'
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    override.vm.box = 'tknerr/managed-server-dummy'

    provider.server = 'example.com'
  end  
```

Install the `vagrant-managed-servers` plugin.

```
$ vagrant plugin install vagrant-managed-servers
```

Provision the server and install Ylosix.

```
$ RAILS_ENV=production vagrant up main_app --provider=managed
$ RAILS_ENV=production vagrant provision main_app
```

#### Docker


Install [Docker](https://docs.docker.com/installation/) and [Docker Compose](https://docs.docker.com/compose/install/) from the official website.

Just run the following commands to create the containers.

```
$ docker-compose up
$ docker-compose run web rake db:create db:migrate db:gen_demo
```


### Troubleshooting

Generate an empty store:

```
$ rake db:create db:migrate db:seed
```

Generate a demo electronic store:
```
$ rake db:create db:migrate db:gen_demo
```


Error when running `bundle install` about the gem `nokoguiri` in Mac OS X (Yosemite):

```
$ port install libiconv libxslt libxml2
$ gem install nokogiri -- --use-system-libraries --with-iconv-dir=/opt/local --with-xml2-dir=/opt/local --with-xslt-dir=/opt/local
```

Error when running `bundle install` about the gem `pg` in Mac OS X (Yosemite).

Download and install postgresql from:

```
http://www.postgresql.org/download/macosx
```
Then run:

```
$ gem install pg -- --with-pg-config=/Library/PostgreSQL/9.4/bin/pg_config
```

If you are cloning the repository from Windows please set `autocrlf` to false to avoid end-of-line issues.

```
git config --global core.autocrlf false
```


### Testing

The tests are developed with the Ruby on Rails minitest suite. TravisCI
automatically runs the tests every time there is a new code change.

To run the test locally just run:

```
$ rake
```


## Dependencies [![Dependency Status](https://gemnasium.com/ylosix/ylosix.svg)](https://gemnasium.com/ylosix/ylosix)

  - Ruby version: 2.1.6+
  - Rails version: 4.2+
  - Puppet: 3.7.5+
  - PostgreSQL: 9.4+
  - Vagrant: 1.7+


## Contributions

To contribute to Ylosix you can freely fork the repository and send us a pull-request. We will review and merge your changes into the repository after we test and validate your contribution.

If you find a bug, want to propose a new feature, find a wrong translation, etc. please create an issue in this GitHub repository.


## License [![License](http://img.shields.io/:license-Apache_v2-blue.svg)](https://raw.githubusercontent.com/ylosix/ylosix/develop/LICENSE)

Ylosix is released under the Apache v2 License.
