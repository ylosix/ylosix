# == Schema Information
#
# Table name: shopping_orders
#
#  billing_address  :hstore           default({}), not null
#  billing_commerce :hstore           default({}), not null
#  commerce_id      :integer
#  created_at       :datetime         not null
#  customer_id      :integer
#  id               :integer          not null, primary key
#  order_num        :integer          not null
#  shipping_address :hstore           default({}), not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_shopping_orders_on_customer_id  (customer_id)
#

require 'test_helper'

class ShoppingOrderTest < ActiveSupport::TestCase
  test 'should to_liquid' do
    hash = shopping_orders(:customer_example_so).to_liquid

    assert hash.key? 'shopping_orders_products'
  end
end
