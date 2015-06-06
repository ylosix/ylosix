class ShoppingCartsController < Frontend::CommonController
  def get_template_variables(template)
    super
  end

  def show
  end

  def update
    params_scp = params_shopping_cart

    sc = ShoppingCart.retrieve(current_customer, session[:shopping_cart])
    sc.update_product(params_scp[:product_id].to_i, params_scp[:quantity].to_i)

    if customer_signed_in?
      sc.save
    else
      session[:shopping_cart] = sc.to_json(include: :shopping_carts_products)
    end

    redirect_to :customers_shopping_carts
  end

  private

  def params_shopping_cart
    params.permit(:product_id, :quantity)
  end
end
