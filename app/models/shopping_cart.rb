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

class ShoppingCart < ActiveRecord::Base
  belongs_to :customer
  has_many :shopping_carts_products

  def remove_product(product)
    shopping_carts_products.where(product_id: product.id).destroy_all
  end

  def add_product(product)
    scp = shopping_cart_product(product)

    if scp.nil?
      scp = ShoppingCartsProduct.new
      scp.product = product
      shopping_carts_products << scp
    else
      scp.quantity += 1
    end

    scp.retail_price = product.retail_price
    # scp.save unless scp.id.nil?
    scp
  end

  private

  def shopping_cart_product(product)
    shopping_carts_products.each do |scp|
      return scp if scp.product_id == product.id
    end

    nil
  end
end
