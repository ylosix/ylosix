# == Schema Information
#
# Table name: shopping_orders
#
#  created_at  :datetime         not null
#  customer_id :integer
#  id          :integer          not null, primary key
#  updated_at  :datetime         not null
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

  test 'retrieve shipping/billing address' do
    so = shopping_orders(:customer_example_so)
    assert !so.shipping_address.nil?
    assert !so.billing_address.nil?
  end
end
