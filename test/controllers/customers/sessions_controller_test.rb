require 'test_helper'

module Customers
  class SessionsControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    def setup
      @request.env['devise.mapping'] = Devise.mappings[:customer]
    end

    test 'should create' do
      customer = customers(:customer_example)

      post :create, customer: {email: customer.email, password: 'password'}
      assert_response :redirect
    end
  end
end
