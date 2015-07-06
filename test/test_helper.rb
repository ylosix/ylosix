require 'coveralls'
require 'codeclimate-test-reporter'
require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    Coveralls::SimpleCov::Formatter,
    SimpleCov::Formatter::HTMLFormatter,
    CodeClimate::TestReporter::Formatter
]

SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

module ActionController
  class TestCase
    include Devise::TestHelpers
  end
end

module ActionDispatch
  class IntegrationTest
    include Devise::TestHelpers
  end
end

Rake::Task['rubocop'].invoke
Rake::Task['db:gen_demo'].invoke

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical
    # order.
    fixtures :all

    # Add more helper methods to be used by all tests here...

    def login_admin
      admin_user = admin_users(:admin_user)
      sign_in admin_user

      admin_user
    end

    def login_customer
      customer = customers(:customer_example)
      sign_in customer

      customer
    end
  end
end
