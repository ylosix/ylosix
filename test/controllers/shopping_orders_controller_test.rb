require 'test_helper'

class ShoppingOrdersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'should get show with login user' do
    login_customer

    get :show
    assert_response :success
  end

  test 'should get addresses with login user' do
    customer = login_customer

    get :addresses, type: 'shipping_address_id'
    assert_response :success

    variables = assigns(:variables)
    assert variables['customer_addresses'].size == customer.customer_addresses.size
  end

  test 'should get finalize with login user' do
    login_customer

    get :finalize
    assert_response :redirect
  end
end
