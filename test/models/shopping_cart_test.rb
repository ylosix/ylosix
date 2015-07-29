# == Schema Information
#
# Table name: shopping_carts
#
#  billing_address_id   :integer
#  carrier_id           :integer
#  carrier_retail_price :decimal(10, 2)   default(0.0), not null
#  created_at           :datetime         not null
#  customer_id          :integer
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

class ShoppingCartTest < ActiveSupport::TestCase
  test 'to_liquid' do
    hash = shopping_carts(:customer_example_sc).to_liquid

    assert hash.key? 'shopping_carts_products'
    assert hash.key? 'total_products'
    assert hash.key? 'total_retail_price'
  end
end
