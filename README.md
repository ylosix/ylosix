[![Build Status](https://travis-ci.org/devcows/ecommerce.svg?branch=develop)](https://travis-ci.org/devcows/ecommerce)
[![Coverage Status](http://img.shields.io/coveralls/devcows/ecommerce/develop.svg)](https://coveralls.io/r/devcows/ecommerce)
[![Code Climate](https://codeclimate.com/github/devcows/ecommerce/badges/gpa.svg)](https://codeclimate.com/github/devcows/ecommerce)
[![Inline docs](http://inch-ci.org/github/devcows/ecommerce.svg?branch=develop)](http://inch-ci.org/github/devcows/ecommerce)

README
=========

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.


Design schema
==============

![Alt text](https://raw.githubusercontent.com/devcows/ecommerce/develop/erd.png "Design")



Devise TODO
===============================================================================

Some setup you must do manually if you haven't yet:

  1. Ensure you have defined default url options in your environments files. Here
     is an example of default_url_options appropriate for a development environment
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

     In production, :host should be set to the actual host of your application.

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"

  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

  4. If you are deploying on Heroku with Rails 3.2 only, you may want to set:

       config.assets.initialize_on_precompile = false

     On config/application.rb forcing your application to not access the DB
     or load models when precompiling your assets.

  5. You can copy Devise views (for customization) to your app by running:

       rails g devise:views
