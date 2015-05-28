# == Schema Information
#
# Table name: shopping_carts_products
#
#  created_at       :datetime         not null
#  id               :integer          not null, primary key
#  product_id       :integer
#  shopping_cart_id :integer
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_shopping_carts_products_on_product_id        (product_id)
#  index_shopping_carts_products_on_shopping_cart_id  (shopping_cart_id)
#

class ShoppingCartsProduct < ActiveRecord::Base
  belongs_to :shopping_cart
  belongs_to :product
end
