# Ylosix

[![Build Status](https://travis-ci.org/ylosix/ylosix.svg?branch=develop)](https://travis-ci.org/ylosix/ylosix)
[![Coverage Status](https://coveralls.io/repos/ylosix/ylosix/badge.svg?branch=develop)](https://coveralls.io/r/ylosix/ylosix?branch=develop)
[![Code Climate](https://codeclimate.com/github/ylosix/ylosix/badges/gpa.svg)](https://codeclimate.com/github/ylosix/ylosix)
[![Hakiri status](https://hakiri.io/github/ylosix/ylosix/develop.svg)](https://hakiri.io/github/ylosix/ylosix)
[![Stories in Ready](https://badge.waffle.io/ylosix/ylosix.png?label=ready&title=Ready)](http://waffle.io/ylosix/ylosix)


`Ylosix` is a new free and open source e-commerce and CMS solution written in Ruby on Rails. It is designed to be highly scalable, easily customizable, and allow plug-and-play modules to provide new features and integrations with other services.

This repository contains the source for the latest version of Ylosix as well as older releases.

### Demo
- [Frontend](http://ylos.ylosix.com)
- [Backoffice](http://ylos.ylosix.com/admin) (email: `admin@ylos.com`, password: `password`)

This project uses `yard` for generate the documentation:
```
$ rake rdoc
```

## Table of contents

  * [Installation](#installation)
  * [Testing](#testing)
  * [Troubleshooting](#troubleshooting)
  * [Dependencies](#dependencies-)
  * [Contributions](#contributions)
  * [License](#license-)


## Installation

The easiest way to install Ylosix either locally, on your managed server, or on the cloud, is to cloning this repository and using Vagrant to deploy it with all its dependencies.

Follow the next instructions to install Ylosix.

Install `git` and clone the repository. Note the `--recursive` parameter to also download git submodules.

```
$ git clone --recursive https://github.com/ylosix/ylosix.git
```

[Download and install Vagrant](http://www.vagrantup.com/downloads.html) from their website according your OS.

### Virtualbox (local installation for testing/development)

If you don't have it already, [download and install Virtualbox and the Extension Pack](https://www.virtualbox.org/wiki/Downloads).

Create the guest machine and provision it.

```
$ vagrant up
$ vagrant ssh -c 'cd /vagrant; rails s Puma -b 0.0.0.0'
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


### Docker


Install [Docker](https://docs.docker.com/installation/) and [Docker Compose](https://docs.docker.com/compose/install/) from the official website.

Just run the following commands to create the containers.

```
$ docker-compose up
$ docker-compose run web rake db:create db:schema:load db:gen_demo
```


## Troubleshooting

Generate an empty store:

```
$ rake db:create db:schema:load db:seed
```

Generate a demo electronic store:
```
$ rake db:create db:schema:load db:gen_demo
```


Error when running `bundle install` about the gem `nokoguiri` in Mac OS X (Yosemite):

```
$ port install libiconv libxslt libxml2
$ gem install nokogiri -- --use-system-libraries --with-iconv-dir=/opt/local --with-xml2-dir=/opt/local --with-xslt-dir=/opt/local

Capitan:
$ gem install nokogiri -- --use-system-libraries=true --with-xml2-include=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk/usr/include/libxml2
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
$ git config --global core.autocrlf false
```

#### Configuring local env variables

The Rails application loads config/local-env.yml, these file contains the variables for non production environments.

```
development:
  DATABASE_URL: postgres://user:user_pass@localhost:5432/database
```

## Testing

The tests are developed with the Ruby on Rails minitest suite. TravisCI
automatically runs the tests every time there is a new code change.

To run the test locally just run:

```
$ rake
```


## Dependencies [![Dependency Status](https://gemnasium.com/ylosix/ylosix.svg)](https://gemnasium.com/ylosix/ylosix)

  - Ruby version: 2.3+
  - Rails version: 4.2+
  - Puppet: 3.7.5+
  - PostgreSQL: 9.4+
  - Vagrant: 1.7+


## Contributions

To contribute to Ylosix you can freely fork the repository and send us a pull-request. We will review and merge your changes into the repository after we test and validate your contribution.

If you find a bug, want to propose a new feature, find a wrong translation, etc. please create an issue in this GitHub repository.


## License [![License](http://img.shields.io/:license-Apache_v2-blue.svg)](https://raw.githubusercontent.com/ylosix/ylosix/develop/LICENSE)

Ylosix is released under the Apache v2 License.
