# == Schema Information
#
# Table name: shopping_orders
#
#  billing_address           :hstore           default({}), not null
#  billing_commerce          :hstore           default({}), not null
#  carrier_id                :integer
#  carrier_retail_price      :decimal(10, 2)   default(0.0), not null
#  commerce_id               :integer
#  created_at                :datetime         not null
#  customer_id               :integer
#  id                        :integer          not null, primary key
#  order_num                 :integer          not null
#  shipping_address          :hstore           default({}), not null
#  shopping_orders_status_id :integer
#  updated_at                :datetime         not null
#
# Indexes
#
#  index_shopping_orders_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_6cc7143c73  (customer_id => customers.id)
#  fk_rails_be0697c8ed  (commerce_id => commerces.id)
#  fk_rails_c71875ef4e  (carrier_id => carriers.id)
#

class ShoppingOrder < ActiveRecord::Base
  include ArrayLiquid

  belongs_to :carrier
  belongs_to :customer
  belongs_to :commerce
  belongs_to :shopping_orders_status
  has_many :shopping_orders_products

  def shopping_orders_products_plus_carrier
    sop = shopping_orders_products.to_a

    sop << {product: '<strong>Shipping</strong>'.html_safe}
    sop << {product: carrier, retail_price_pre_tax: 0, retail_price: 0}
    sop
  end

  def self.from_shopping_cart(sc, commerce)
    so = ShoppingOrder.new
    so.customer = sc.customer
    so.carrier = sc.carrier
    so.carrier_retail_price = sc.carrier_retail_price

    so.shipping_address = sc.shipping_address.fields
    so.billing_address = sc.billing_address.fields

    unless commerce.nil?
      so.commerce = commerce
      so.billing_commerce = commerce.billing_address
    end

    sc.shopping_carts_products.each do |scp|
      so.shopping_orders_products << scp.to_shopping_order
    end

    so
  end

  def retrieve_order_num
    if commerce.nil? || commerce.order_prefix.blank?
      str = order_num.to_s
    else
      str = created_at.strftime(commerce.order_prefix.gsub('%order_num', order_num.to_s))
    end

    str
  end

  def total_taxes
    shopping_orders_products.inject(0) do |a, e|
      a + (e.retail_price - e.retail_price_pre_tax) * e.quantity
    end
  end

  def total_products
    shopping_orders_products.inject(0) { |a, e| a + e.quantity }
  end

  def total_retail_price_pre_tax
    products_prices = shopping_orders_products.map { |e| e.retail_price_pre_tax * e.quantity }
    products_prices.reduce(:+)
  end

  def total_retail_price
    products_prices = shopping_orders_products.map { |e| e.retail_price * e.quantity }
    products_prices.reduce(:+)
  end

  def total_weight
    shopping_orders_products.inject(0) { |a, e| a + (e.product.weight * e.quantity) }
  end

  def to_liquid
    {
        'order_num' => retrieve_order_num,
        'shopping_orders_products' => array_to_liquid(shopping_orders_products),
        'total_products' => total_products,
        'total_taxes' => total_taxes,
        'total_weight' => total_weight,
        'total_retail_price_pre_tax' => total_retail_price_pre_tax,
        'total_retail_price' => total_retail_price
    }
  end
end
