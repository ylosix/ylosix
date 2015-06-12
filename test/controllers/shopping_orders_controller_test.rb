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

  test 'should save address' do
    customer = login_customer
    address = customer.customer_addresses.first

    sc = customer.shopping_cart
    sc.shipping_address_id = nil
    sc.billing_address_id = nil

    assert sc.save
    assert sc.shipping_address_id.nil?
    assert sc.billing_address_id.nil?

    get :save_address, type: 'shipping_address_id', id: address.id
    assert_response :redirect

    sc.reload
    assert sc.shipping_address_id == address.id
    assert sc.billing_address_id.nil?

    get :save_address, type: 'billing_address_id', id: address.id
    assert_response :redirect

    sc.reload
    assert sc.shipping_address_id == address.id
    assert sc.billing_address_id == address.id
  end
end
