class ShoppingCartsController < Frontend::CommonController
  def append_variables
    super
  end

  def show
    add_breadcrumb(Breadcrumb.new(url: show_shopping_carts_path, name: 'Cart'))
  end

  def update
    params_scp = params_shopping_cart_product

    sc = ShoppingCart.retrieve(current_customer, session[:shopping_cart])
    sc.update_product(params_scp[:product_id].to_i, params_scp[:quantity].to_i)

    if customer_signed_in?
      sc.save
    else
      session[:shopping_cart] = sc.to_json(include: :shopping_carts_products)
    end

    redirect_to :show_shopping_carts
  end

  def save
    params_sc = params_shopping_cart

    sc = ShoppingCart.retrieve(current_customer, session[:shopping_cart])
    sc.extra_fields = params_sc[:extra_fields] unless params_sc[:extra_fields].nil?

    if customer_signed_in?
      sc.save
    else
      session[:shopping_cart] = sc.to_json(include: :shopping_carts_products)
    end

    redirect_to :shipping_method_customers_shopping_orders
  end

  protected

  def set_breadcrumbs
    add_breadcrumb(Breadcrumb.new(url: show_customers_path, name: 'Customers'))
  end

  def params_shopping_cart_product
    params.permit(:product_id, :quantity)
  end

  def params_shopping_cart
    params.require(:shopping_cart).permit(extra_fields: [:observations])
  end
end
