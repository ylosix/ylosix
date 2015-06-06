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

class ShoppingOrder < ActiveRecord::Base
  belongs_to :customer
  has_many :shopping_orders_products

  def total
    products_prices = shopping_orders_products.map { |e| e.retail_price * e.quantity }
    products_prices.reduce(:+)
  end

  def to_liquid
    {
        'shopping_orders_products' => shopping_orders_products
    }
  end
end
