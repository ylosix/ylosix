class ShoppingCartsController < CommonFrontendController
  def get_template_variables(template)
    super

    get_shopping_cart_products
  end

  def show
    get_shopping_cart_products
  end

  private

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
