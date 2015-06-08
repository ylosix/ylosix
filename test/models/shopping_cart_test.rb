# == Schema Information
#
# Table name: shopping_carts
#
#  created_at  :datetime         not null
#  customer_id :integer
#  id          :integer          not null, primary key
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_shopping_carts_on_customer_id  (customer_id)
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
