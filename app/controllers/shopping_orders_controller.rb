class ShoppingOrdersController < Frontend::CommonController
  before_action :authenticate_customer!
  before_action :check_addresses, only: :finalize

  def get_template_variables(template)
    super
  end

  def show
    # TODO add message cart empty.
  end

  def addresses
    @type = params[:type]
    @customer_addresses = current_customer.customer_addresses
  end

  # TODO change this event for post.
  # TODO check id is related with customer.
  # TODO check param type
  def save_address
    @type = params[:type]
    id = params[:id]

    attributes = {}
    attributes[@type] = id
    sc = current_customer.shopping_cart
    unless sc.nil?
      sc.attributes = attributes
      sc.save
    end

    redirect_to :customers_shopping_orders
  end

  def finalize
    sc = current_customer.shopping_cart

    unless sc.nil?
      so = ShoppingOrder.new
      so.customer = current_customer

      soa = ShoppingOrdersAddress.new(fields: sc.shipping_address.fields, shipping: true)
      so.shopping_orders_addresses << soa
      soa = ShoppingOrdersAddress.new(fields: sc.shipping_address.fields, billing: true)
      so.shopping_orders_addresses << soa

      sc.shopping_carts_products.each do |scp|
        so.shopping_orders_products << scp.to_shopping_order
      end

      so.save
      sc.destroy
    end

    redirect_to :show_customers
  end

  private

  def check_addresses
    sc = current_customer.shopping_cart

    if sc.nil?
      redirect_to :customers_shopping_carts, alert: 'Shopping cart not set.'
      return
    end

    if sc.shipping_address.nil? || sc.billing_address.nil?
      redirect_to :customers_shopping_orders,
                  alert: 'To finalize the purchase sets before the shipping and billing address.'
    end
  end
end
