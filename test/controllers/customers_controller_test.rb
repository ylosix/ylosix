require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  test 'should get show with login user' do
    login_customer

    get :show
  end

  test 'should get orders with login user' do
    login_customer

    get :orders
  end
end
