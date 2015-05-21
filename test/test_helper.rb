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

class ActionController::TestCase
  include Devise::TestHelpers
end

class ActionDispatch::IntegrationTest
  include Devise::TestHelpers
end

# load "#{Rails.root}/db/seeds.rb"
#
# def test_again_seed
#   create_default_languages
#   create_default_roles
#   create_default_admin_user
#   create_default_categories
#   create_default_tags
#   create_default_products
# end
#
# test_again_seed
# Rake::Task['rubocop'].invoke

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
  end
end
