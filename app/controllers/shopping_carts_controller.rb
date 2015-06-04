class ShoppingCartsController < Frontend::CommonController
  def get_template_variables(template)
    super

    @variables['shopping_cart'] = nil
    if customer_signed_in?
      @variables['shopping_cart'] = current_customer.shopping_cart
    end
  end

  def show
  end

  def update
    if customer_signed_in? && !current_customer.shopping_cart.nil?
      modify_shopping_cart
    end

    redirect_to :customers_shopping_carts
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
end
