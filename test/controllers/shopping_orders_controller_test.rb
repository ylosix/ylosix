# == Schema Information
#
# Table name: shopping_orders
#
#  billing_address           :hstore           default({}), not null
#  billing_commerce          :hstore           default({}), not null
#  carrier_id                :integer
#  carrier_retail_price      :decimal(10, 2)   default(0.0), not null
#  commerce_id               :integer
#  created_at                :datetime         not null
#  customer_id               :integer
#  extra_fields              :hstore           default({}), not null
#  id                        :integer          not null, primary key
#  order_num                 :integer          not null
#  shipping_address          :hstore           default({}), not null
#  shopping_orders_status_id :integer
#  updated_at                :datetime         not null
#
# Indexes
#
#  index_shopping_orders_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_6cc7143c73  (customer_id => customers.id)
#  fk_rails_be0697c8ed  (commerce_id => commerces.id)
#  fk_rails_c71875ef4e  (carrier_id => carriers.id)
#

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
    post :finalize, shopping_cart: {extra_fields: {observations: 'blabla'}}
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
    assert sc.billing_address_id == address.id

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
