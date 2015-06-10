# == Schema Information
#
# Table name: shopping_carts
#
#  billing_address_id  :integer
#  created_at          :datetime         not null
#  customer_id         :integer
#  id                  :integer          not null, primary key
#  shipping_address_id :integer
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_shopping_carts_on_customer_id  (customer_id)
#

class ShoppingCart < ActiveRecord::Base
  include LiquidExtension

  belongs_to :customer
  has_many :shopping_carts_products

  belongs_to :shipping_address, class_name: 'CustomerAddress', foreign_key: 'shipping_address_id'
  belongs_to :billing_address, class_name: 'CustomerAddress', foreign_key: 'billing_address_id'

  def initialize(customer = nil)
    super

    self.shipping_address = customer.shipping_address unless customer.nil?
    self.billing_address = customer.billing_address unless customer.nil?
  end

  def total_products
    shopping_carts_products.inject(0) { |a, e| a + e.quantity }
  end

  def total_retail_price
    products_prices = shopping_carts_products.map { |e| e.product.retail_price * e.quantity }
    products_prices.reduce(:+)
  end

  def remove_product(product)
    shopping_carts_products.where(product_id: product.id).destroy_all
  end

  def update_product(product_id, quantity)
    shopping_carts_products.each do |scp|
      if scp.product_id == product_id
        scp.quantity = quantity
        break
      end
    end
  end

  def add_product(product)
    scp = shopping_carts_product(product)

    if scp.nil?
      scp = ShoppingCartsProduct.new
      scp.product = product
      shopping_carts_products << scp
    else
      scp.quantity += 1
    end

    scp.retail_price = product.retail_price
    scp.save unless id.nil?
    scp
  end

  def self.retrieve(customer, string)
    sc = customer.shopping_cart unless customer.nil?
    sc ||= ShoppingCart.new(customer)
    return sc if string.blank?

    # Load shopping cart from session variable.
    hash = ActiveSupport::JSON.decode(string)
    sc.attributes = hash.except('shopping_carts_products')

    sc.shopping_carts_products = []
    hash['shopping_carts_products'].each do |scp|
      sc.shopping_carts_products << ShoppingCartsProduct.new(scp)
    end

    sc
  end

  def to_liquid
    {
        'shopping_carts_products' => array_to_liquid(shopping_carts_products),
        'total_products' => total_products,
        'total_retail_price' => total_retail_price
    }
  end

  private

  def shopping_carts_product(product)
    shopping_carts_products.each do |scp|
      return scp if scp.product_id == product.id
    end

    nil
  end
  #
  # def retrieve_address(address_id)
  #   nil if address_id.nil?
  #   CustomerAddress.find(address_id)
  # end
end
