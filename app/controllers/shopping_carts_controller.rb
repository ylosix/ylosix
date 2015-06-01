class ShoppingCartsController < CommonFrontendController
  def get_template_variables(template)
    super
  end

  def show
    @cart_products = []
    if customer_signed_in?
      sc = current_customer.shopping_cart
      @cart_products = sc.shopping_carts_products
    end
  end
end
