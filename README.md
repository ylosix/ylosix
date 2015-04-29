[![Build Status](https://travis-ci.org/devcows/ecommerce.svg?branch=develop)](https://travis-ci.org/devcows/ecommerce)
[![Dependency Status](https://gemnasium.com/devcows/ecommerce.svg)](https://gemnasium.com/devcows/ecommerce)
[![Coverage Status](https://coveralls.io/repos/devcows/ecommerce/badge.svg?branch=develop)](https://coveralls.io/r/devcows/ecommerce?branch=develop)
[![Code Climate](https://codeclimate.com/github/devcows/ecommerce/badges/gpa.svg)](https://codeclimate.com/github/devcows/ecommerce)
[![Inline docs](http://inch-ci.org/github/devcows/ecommerce.svg?branch=develop)](http://inch-ci.org/github/devcows/ecommerce)

## REAME

Open source for ecommerce.

* Ruby version: 2.1.0

* [Installation](#Installation)

* Configuration

* [Design schema](#Design schema)

* [Database creation](#Database creation)

* [How to run the test suite](#testing)

* [The ecommerce](#The ecommerce)

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.


## Installation

To install download [Vagrant](https://www.vagrantup.com) and install it. Install Vagrant plugin triggers, open a console and type:

```
$ vagrant plugin install vagrant-triggers
```

After open a console in project path:

```
$ vagrant up
```

The first time Vagrant takes more time and prepare the virtual machine. The next runs Vagrant goes more quickly.

After vagrant up the application is running at:
http://localhost:13000


## Design schema

![Alt text](https://raw.githubusercontent.com/devcows/ecommerce/develop/erd.png "Design")



## Database creation

```
$ rake db:create
$ rake db:migrate
$ rake db:fixtures:load RAILS_ENV=development
```

## Testing

```
$ rake
```


## The ecommerce

The main web application is running at:
http://localhost:13000

For the backoffice the application creates a default user {:email => 'admin@example.com', :password => 'password' } and the service is running at:
http://localhost:13000/admin
