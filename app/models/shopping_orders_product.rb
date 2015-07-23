# == Schema Information
#
# Table name: shopping_orders_products
#
#  created_at           :datetime         not null
#  id                   :integer          not null, primary key
#  product_id           :integer
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
# Foreign Keys
#
#  fk_rails_06baf62b18  (shopping_order_id => shopping_orders.id)
#  fk_rails_a5314c7221  (product_id => products.id)
#

class ShoppingOrdersProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :shopping_order

  def to_liquid
    {
        'quantity' => quantity,
        'product' => product.to_liquid,
        'retail_price' => retail_price,
        'retail_price_pre_tax' => retail_price_pre_tax,
        'tax_rate' => tax_rate
    }
  end
end
