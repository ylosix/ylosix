# == Schema Information
#
# Table name: shopping_carts
#
#  billing_address_id   :integer
#  carrier_id           :integer
#  carrier_retail_price :decimal(10, 2)   default(0.0), not null
#  created_at           :datetime         not null
#  customer_id          :integer
#  extra_fields         :hstore           default({}), not null
#  id                   :integer          not null, primary key
#  shipping_address_id  :integer
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_shopping_carts_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_7725ef05cb  (billing_address_id => customer_addresses.id)
#  fk_rails_95c2cdac1a  (shipping_address_id => customer_addresses.id)
#  fk_rails_a4cc6e935e  (customer_id => customers.id)
#

require 'test_helper'

class ShoppingCartsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'should get show' do
    get :show
    assert_response :success
  end

  test 'should get show with login user' do
    login_customer

    get :show
    assert_response :success
  end

  test 'should post save' do
    login_customer

    post :save, shopping_cart: {extra_fields: {observations: 'blabla'}}
    assert_response :redirect
  end

  test 'should get update with login user' do
    login_customer
    scp = shopping_carts_products(:scp_camera)

    get :update, product_id: scp.product.id, quantity: 5
    assert_response :redirect
  end
end
