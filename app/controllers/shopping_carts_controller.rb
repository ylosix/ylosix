# == Schema Information
#
# Table name: shopping_carts
#
#  billing_address_id   :integer
#  carrier_id           :integer
#  carrier_retail_price :decimal(10, 2)   default(0.0), not null
#  created_at           :datetime         not null
#  customer_id          :integer
#  extra_fields         :hstore           default({}), not null
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

class ShoppingCartsController < Frontend::CommonController
  def append_variables
    super
  end

  def show
    add_breadcrumb(Breadcrumb.new(url: show_shopping_carts_path, name: 'Cart'))
  end

  def clear
    sc = ShoppingCart.retrieve(current_customer, session[:shopping_cart])
    sc.clear_products
    save_shopping_cart(sc)

    redirect_to :show_shopping_carts
  end

  def update
    params_scp = params_shopping_cart_product

    sc = ShoppingCart.retrieve(current_customer, session[:shopping_cart])
    sc.update_product(params_scp[:product_id].to_i, params_scp[:quantity].to_i)

    save_shopping_cart(sc)

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

  def save_shopping_cart(sc)
    if customer_signed_in?
      sc.save
    else
      session[:shopping_cart] = sc.to_json(include: :shopping_carts_products)
    end
  end

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
