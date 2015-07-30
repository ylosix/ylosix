# == Schema Information
#
# Table name: shopping_carts
#
#  billing_address_id   :integer
#  carrier_id           :integer
#  carrier_retail_price :decimal(10, 2)   default(0.0), not null
#  created_at           :datetime         not null
#  customer_id          :integer
#  id                   :integer          not null, primary key
#  shipping_address_id  :integer
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_shopping_carts_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_7725ef05cb  (billing_address_id => customer_addresses.id)
#  fk_rails_95c2cdac1a  (shipping_address_id => customer_addresses.id)
#  fk_rails_a4cc6e935e  (customer_id => customers.id)
#

class ShoppingCart < ActiveRecord::Base
  include ArrayLiquid

  belongs_to :carrier
  belongs_to :customer
  has_many :shopping_carts_products, autosave: true

  belongs_to :shipping_address, touch: true, class_name: 'CustomerAddress', foreign_key: 'shipping_address_id'
  belongs_to :billing_address, touch: true, class_name: 'CustomerAddress', foreign_key: 'billing_address_id'

  before_save :calculate_shipping_cost

  def initialize(attributes = {}, options = {})
    super

    self.shipping_address = customer.shipping_address unless customer.nil?
    self.billing_address = customer.billing_address unless customer.nil?
  end

  def total_products
    shopping_carts_products.inject(0) { |a, e| a + e.quantity }
  end

  def total_weight
    shopping_carts_products.inject(0) { |a, e| a + (e.product.weight * e.quantity) }
  end

  def total_retail_price
    array_prices = shopping_carts_products.map { |e| e.product.retail_price * e.quantity }
    products_prices = array_prices.reduce(:+)
    products_prices ||= 0

    products_prices + carrier_retail_price
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

  def self.retrieve(customer, session_variable)
    sc = customer.shopping_cart unless customer.nil?
    sc ||= ShoppingCart.new(customer: customer)

    ShoppingCart.retrieve_products(sc, session_variable)
    sc.save unless customer.nil?
    sc
  end

  def to_liquid
    {
        'shopping_carts_products' => array_to_liquid(shopping_carts_products),
        'total_products' => total_products,
        'total_weight' => total_weight,
        'total_retail_price' => total_retail_price
    }
  end

  private

  def calculate_shipping_cost
    self.carrier_retail_price = 0

    if !shipping_address.nil? && !carrier.nil?
      country_code = shipping_address.country
      self.carrier_retail_price = carrier.calculate_shipping_cost_to(country_code, total_weight)
    end
  end

  def shopping_carts_product(product)
    shopping_carts_products.each do |scp|
      return scp if scp.product_id == product.id
    end

    nil
  end

  def self.retrieve_products(sc, session_variable)
    # Load shopping cart from session variable.
    unless session_variable.blank?
      hash = ActiveSupport::JSON.decode(session_variable)

      sc.shopping_carts_products = []
      hash['shopping_carts_products'].each do |scp|
        sc.shopping_carts_products << ShoppingCartsProduct.new(scp)
      end
    end
  end
end
