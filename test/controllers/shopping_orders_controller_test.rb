require 'test_helper'

class ShoppingOrdersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @customer = login_customer
  end

  test 'should get shipping_method' do
    get :shipping_method
    assert_response :success
  end

  test 'should get show with login user' do
    get :checkout
    assert_response :success
  end

  test 'should get addresses with login user' do
    get :addresses, type: 'shipping_address_id'
    assert_response :success

    variables = assigns(:variables)
    assert variables['customer_addresses'].size == @customer.customer_addresses.size
  end

  test 'should get finalize with login user' do
    get :finalize
    assert_response :redirect
  end

  test 'should save address' do
    address = @customer.customer_addresses.first

    sc = @customer.shopping_cart
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

  test 'should save carrier' do
    carrier = carriers(:one)
    post :save_carrier, carrier: carrier
    assert_response :redirect
  end
end
