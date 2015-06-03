class ShoppingCartsController < CommonFrontendController
  def get_template_variables(template)
    super

    get_shopping_cart_products
  end

  def show
    get_shopping_cart_products
  end

  def update
    if customer_signed_in? && !current_customer.shopping_cart.nil?
      modify_shopping_cart
    end

    redirect_to :shopping_carts_customers
  end

  private

  def params_shopping_cart
    params.permit(:shopping_cart_product_id, :quantity)
  end

  def modify_shopping_cart
    params_scp = params_shopping_cart
    scp = ShoppingCartsProduct.find_by(id: params_scp[:shopping_cart_product_id])
    sc = current_customer.shopping_cart

    return if scp.shopping_cart.id != sc.id

    scp.quantity = params_scp[:quantity]
    scp.save
    # TODO save Shopping Cart in cache
  end

  def get_shopping_cart_products
    @variables['shopping_cart_products'] = []
    if customer_signed_in?
      sc = current_customer.shopping_cart

      unless sc.nil?
        @variables['shopping_cart_products'] = sc.shopping_carts_products
      end
    end
  end
end
