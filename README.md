[![Build Status](https://travis-ci.org/ylosix/ylosix.svg?branch=develop)](https://travis-ci.org/ylosix/ylosix)
[![Dependency Status](https://gemnasium.com/ylosix/ylosix.svg)](https://gemnasium.com/ylosix/ylosix)
[![Coverage Status](https://coveralls.io/repos/ylosix/ylosix/badge.svg?branch=develop)](https://coveralls.io/r/ylosix/ylosix?branch=develop)
[![Code Climate](https://codeclimate.com/github/ylosix/ylosix/badges/gpa.svg)](https://codeclimate.com/github/ylosix/ylosix)
[![Inline docs](http://inch-ci.org/github/ylosix/ylosix.svg?branch=develop)](http://inch-ci.org/github/ylosix/ylosix)
[![security](https://hakiri.io/github/ylosix/ylosix/develop.svg)](https://hakiri.io/github/ylosix/ylosix)
[![License](http://img.shields.io/:license-Apache_v2-blue.svg)](https://raw.githubusercontent.com/ylosix/ylosix/develop/LICENSE)

## YLOSIX

Ylosix is an open source project, the main goal is provides a CMS for build your site.
We focus at E-commerce sites, we are looking for clean and effective code also in
the frontend the project includes bootstrap, font-awesome and animate.

Beta demo:
- [Frontend](http://ylos.ylosix.com)
- [Backoffice](http://ylos.ylosix.com/admin)

The default customer user is {:email => 'user@example.com', :password => 'password' }.<br />
The default admin user is {:email => 'admin@example.com', :password => 'password' }.

  * [Dependencies](#dependencies)
  * [Getting started](#getting-started)   
    * [Installation](#installation)
    * [Deploy at production environments](#deploy-at-production-environments)
    * [Testing](#testing)
    * [TODO] Docs

  * [Collaboration](#collaboration)
  * [License](#license)


## Dependencies

  * Ruby version: 2.1.6
  * Rails version: 4.2.3
  * Puppet: 3.7.5


## Getting started

### Installation

  Install git and after clone the repository(be careful with submodules):

  ```
  $ git clone --recursive https://github.com/devcows/ecommerce.git
  ```

  To install Vagrant download [Vagrant](https://www.vagrantup.com) and install it. Install Vagrant plugin triggers, open a console and type:

  ```
  $ vagrant plugin install vagrant-triggers
  ```

  After open a console in project path:

  ```
  $ vagrant up main_app
  ```

  The first time Vagrant takes more time and prepare the virtual machine. The next runs Vagrant goes more quickly.

  After vagrant up, you already have a develop environment, the application is running at: <br />
  - Main web: [http://localhost:13000](http://localhost:13000)
  - Back office: [http://localhost:13000/admin](http://localhost:13000/admin)

  The default customer user is {:email => 'user@example.com', :password => 'password' }.<br />
  The default admin user is {:email => 'admin@example.com', :password => 'password' }.

  The default Postgresql config: <br />
    - Port: 15432 <br />
    - Database: ecommerce <br />
    - User: ecommerce_user <br />
    - Password: ecommerce_pass <br />

  Database considerations:

  ```
  $ rake db:create db:migrate db:seed       #Empty Ecommerce
  $ rake db:create db:migrate db:gen_demo   #Demo Ecommerce
  ```

  Troubleshooting gem nokoguiri in Mac os x (Yosemite):
  ```
  $ port install libiconv libxslt libxml2
  $ gem install nokogiri -- --use-system-libraries --with-iconv-dir=/opt/local --with-xml2-dir=/opt/local --with-xslt-dir=/opt/local
  ```

  Troubleshooting gem pg in Mac os x (Yosemite):
  ```
  Download and install postgresql from:
  http://www.postgresql.org/download/macosx

  And after:

  $ gem install pg -- --with-pg-config=/Library/PostgreSQL/9.4/bin/pg_config
  ```

  Troubleshooting git clone in windows:
    - Windows by default use crlf true and adds \r in every \n. The puppet recipe fails with \r.
  ```
  git config --global core.autocrlf false
  ```


### Deploy at production environments

__With heroku:__
  - Register at [heroku](https://www.heroku.com)
  - Install [heroku cli](https://toolbelt.heroku.com)

  ```
  $ git clone --recursive https://github.com/devcows/ecommerce.git
  $ cd ecommerce
  $ heroku login
  $ heroku create
  $ heroku addons:add heroku-postgresql:hobby-dev
  $ heroku config:set RAILS_DB=postgresql
  $ git push heroku develop:master

  $ heroku run rake db:migrate RAILS_ENV=production
  $ heroku run rake db:gen_demo
  ```

__With digital ocean:__
  ```
  $ vagrant plugin install vagrant-digitalocean
  ```

  - Generate API token:
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

  - Execute:
  ```
  $ git clone --recursive https://github.com/devcows/ecommerce.git
  $ cd ecommerce
  $ RAILS_ENV=production vagrant up main_app --provider=digital_ocean
  ```

__With a managed server:__

  - Add server ssh config:
  ```
    app.vm.provider :managed do |provider, override|
      override.ssh.username = 'username'
      override.ssh.private_key_path = '~/.ssh/id_rsa'
      override.vm.box = 'tknerr/managed-server-dummy'

      provider.server = 'example.com'
    end  
  ```

  - Execute:
  ```
  $ vagrant plugin install vagrant-managed-servers
  $ git clone --recursive https://github.com/devcows/ecommerce.git
  $ cd ecommerce
  $ RAILS_ENV=production vagrant up main_app --provider=managed
  $ RAILS_ENV=production vagrant provision main_app
  ```

  - Troubleshooting Puppet old version:
    https://docs.puppetlabs.com/guides/install_puppet/install_debian_ubuntu.html

__With docker:__
  - Install docker and docker-compose.
  - Execute:
  ```
  $ docker-compose up
  $ docker-compose run web rake db:create db:migrate db:gen_demo
  ```


### Testing

The tests are developed with the Ruby on Rails minitest suite. Travis-ci
automatically run the test on github commits and to run the test at local machine
execute:
```
$ rake
```


## Collaboration

To collaborate with us use github issues and pull-request.

Also you can follow us at [Jira](https://ylos-hispania.atlassian.net/secure/Dashboard.jspa).


## License

Ylosix is released under the Apache v2 License.
