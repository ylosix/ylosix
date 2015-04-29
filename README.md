[![Build Status](https://travis-ci.org/devcows/ecommerce.svg?branch=develop)](https://travis-ci.org/devcows/ecommerce)
[![Dependency Status](https://gemnasium.com/devcows/ecommerce.svg)](https://gemnasium.com/devcows/ecommerce)
[![Coverage Status](https://coveralls.io/repos/devcows/ecommerce/badge.svg?branch=develop)](https://coveralls.io/r/devcows/ecommerce?branch=develop)
[![Code Climate](https://codeclimate.com/github/devcows/ecommerce/badges/gpa.svg)](https://codeclimate.com/github/devcows/ecommerce)
[![Inline docs](http://inch-ci.org/github/devcows/ecommerce.svg?branch=develop)](http://inch-ci.org/github/devcows/ecommerce)

README
=========

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: 2.1.0

* [Installation](#installation)

* Configuration

* Database creation

* Database initialization

* [How to run the test suite](#test)

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.


Design schema
=============

![Alt text](https://raw.githubusercontent.com/devcows/ecommerce/develop/erd.png "Design")


## Installation

Set up server:
TODO

Set up database:

```
$ rake db:create
$ rake db:migrate
$ rake db:fixtures:load RAILS_ENV=development
```

## Test

```
$ rake
```

