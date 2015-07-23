# == Schema Information
#
# Table name: shopping_carts_products
#
#  created_at       :datetime         not null
#  id               :integer          not null, primary key
#  product_id       :integer
#  quantity         :integer          default(1), not null
#  retail_price     :decimal(10, 2)   default(0.0), not null
#  shopping_cart_id :integer
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_shopping_carts_products_on_product_id        (product_id)
#  index_shopping_carts_products_on_shopping_cart_id  (shopping_cart_id)
#
# Foreign Keys
#
#  fk_rails_1ba11f7c1b  (shopping_cart_id => shopping_carts.id)
#  fk_rails_d696c60c99  (product_id => products.id)
#

class ShoppingCartsProduct < ActiveRecord::Base
  belongs_to :shopping_cart
  belongs_to :product

  def to_shopping_order
    sop = ShoppingOrdersProduct.new

    sop.quantity = quantity
    sop.product = product
    sop.retail_price = product.retail_price
    sop.retail_price_pre_tax = product.retail_price_pre_tax
    sop.tax_rate = product.tax.rate unless product.tax.nil?

    sop
  end

  def to_liquid
    {
        'product' => product.to_liquid,
        'quantity' => quantity,
        'retail_price' => retail_price
    }
  end
end
