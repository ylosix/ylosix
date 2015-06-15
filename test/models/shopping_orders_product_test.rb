# == Schema Information
#
# Table name: shopping_orders_products
#
#  created_at           :datetime         not null
#  id                   :integer          not null, primary key
#  product_id           :uuid
#  quantity             :integer          default(1), not null
#  retail_price         :decimal(10, 2)   default(0.0), not null
#  retail_price_pre_tax :decimal(10, 5)   default(0.0), not null
#  shopping_order_id    :integer
#  tax_rate             :decimal(5, 2)    default(0.0), not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_shopping_orders_products_on_product_id         (product_id)
#  index_shopping_orders_products_on_shopping_order_id  (shopping_order_id)
#

require 'test_helper'

class ShoppingOrdersProductTest < ActiveSupport::TestCase
  test 'should to_liquid' do
    hash = shopping_orders_products(:sop_camera).to_liquid

    assert hash.key? 'product'
    assert hash.key? 'quantity'
    assert hash.key? 'retail_price'
  end
end
