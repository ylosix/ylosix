[![Build Status](https://travis-ci.org/devcows/ecommerce.svg?branch=develop)](https://travis-ci.org/devcows/ecommerce)
[![Dependency Status](https://gemnasium.com/devcows/ecommerce.svg)](https://gemnasium.com/devcows/ecommerce)
[![Coverage Status](https://coveralls.io/repos/devcows/ecommerce/badge.svg?branch=develop)](https://coveralls.io/r/devcows/ecommerce?branch=develop)
[![Code Climate](https://codeclimate.com/github/devcows/ecommerce/badges/gpa.svg)](https://codeclimate.com/github/devcows/ecommerce)
[![Inline docs](http://inch-ci.org/github/devcows/ecommerce.svg?branch=develop)](http://inch-ci.org/github/devcows/ecommerce)
[![security](https://hakiri.io/github/devcows/ecommerce/develop.svg)](https://hakiri.io/github/devcows/ecommerce/develop)

## REAME

Open source ecommerce.

* Ruby version: 2.1.6

* Rails version: 4.2.1

* Puppet: 3.7.5

* [Installation](#installation)

* Configuration

* [Design schema](#design-schema)

* [Database creation](#database-creation)

* [How to run the test suite](#testing)

* [The ecommerce](#the-ecommerce)

* Services (job queues, cache servers, search engines, etc.)

* [Deployment instructions](#deployment-instructions)


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.


## Installation

Install git and after clone the repository(be careful with submodules):

```
$ git clone --recursive https://github.com/devcows/ecommerce.git
```

To install download [Vagrant](https://www.vagrantup.com) and install it. Install Vagrant plugin triggers, open a console and type:

```
$ vagrant plugin install vagrant-triggers
```

After open a console in project path:

```
$ vagrant up main_app
```

The first time Vagrant takes more time and prepare the virtual machine. The next runs Vagrant goes more quickly.

After vagrant up, you already have a develop environment, the application is running at: <br />
[http://localhost:13000](http://localhost:13000)

Troubleshooting gem nokoguiri in Mac os x (Yosemite):
```
$ port install libiconv libxslt libxml2
$ gem install nokogiri -- --use-system-libraries --with-iconv-dir=/opt/local --with-xml2-dir=/opt/local --with-xslt-dir=/opt/local
```

Troubleshooting git clone in windows:
- Windows by default use crlf true and adds \r in every \n. The puppet recipe fails with \r. 
```
git config --global core.autocrlf false
```

Build and run with docker:
```
# build your dockerfile
$ docker build -t ryanfox1985/ecommerce .

# run container
$ docker run -d -p 80:80 -e SECRET_KEY_BASE=secretkey ryanfox1985/ecommerce

# run console
docker run -i -t ryanfox1985/ecommerce:latest /bin/bash
```

## Design schema

![Alt text](https://raw.githubusercontent.com/devcows/ecommerce/develop/erd.png "Design")


## Database creation

```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

## Testing

```
$ rake
```

## The ecommerce

The main web application is running at: <br />
[http://localhost:13000](http://localhost:13000)

The application backoffice is running at: <br />
[http://localhost:13000/admin](http://localhost:13000/admin)

The default user is {:email => 'admin@example.com', :password => 'password' }.

Demo at: <br />
[Link to heroku](http://devcows-ecommerce.herokuapp.com)

## Deployment instructions

Deploy using heroku:
- Register at [heroku](https://www.heroku.com)

```
$ git clone --recursive https://github.com/devcows/ecommerce.git
$ cd ecommerce
$ heroku login
$ heroku create
$ heroku addons:add heroku-postgresql:hobby-dev
$ heroku config:set RAILS_DB=postgresql
$ git push heroku master_heroku:master

$ heroku run rake db:migrate RAILS_ENV=production
$ heroku run rake db:seed
```

Deploy using digital ocean:
```
$ vagrant plugin install vagrant-digitalocean
```

Generate API token:
https://cloud.digitalocean.com/settings/applications

- Add token code in Vagrant file at YOUR_TOKEN:
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

Execute:
```
$ git clone --recursive https://github.com/devcows/ecommerce.git
$ cd ecommerce
$ RAILS_ENV=production vagrant up main_app --provider=digital_ocean
```

Managed servers:

- Add server ssh config:
```
  app.vm.provider :managed do |provider, override|
    override.ssh.username = 'username'
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    override.vm.box = 'tknerr/managed-server-dummy'

    provider.server = 'example.com'
  end  
```

Execute:
```
$ vagrant plugin install vagrant-managed-servers
$ git clone --recursive https://github.com/devcows/ecommerce.git
$ cd ecommerce
$ RAILS_ENV=production vagrant up main_app --provider=managed
$ RAILS_ENV=production vagrant provision main_app
```

Troubleshooting Puppet old version:
https://docs.puppetlabs.com/guides/install_puppet/install_debian_ubuntu.html