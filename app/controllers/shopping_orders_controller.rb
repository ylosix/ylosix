class ShoppingOrdersController < Frontend::CommonController
  before_action :authenticate_customer!

  def get_template_variables(template)
    super
  end

  def show
    # TODO verify cart empty.
  end

  def finalize
    if customer_signed_in?
      sc = current_customer.shopping_cart

      unless sc.nil?
        so = ShoppingOrder.new
        so.customer = current_customer

        sc.shopping_carts_products.each do |scp|
          so.shopping_orders_products << scp.to_shopping_order
        end

        so.save
        sc.destroy
      end
    end

    redirect_to :show_customers
  end
end
