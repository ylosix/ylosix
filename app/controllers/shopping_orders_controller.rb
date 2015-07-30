class ShoppingOrdersController < Frontend::CommonController
  layout 'shopping'

  before_action :authenticate_customer!
  before_action :check_addresses, only: [:finalize, :shipping_method]

  def get_template_variables(template)
    super

    @variables['finalize_shopping_order_href'] = finalize_customers_shopping_orders_path
  end

  def checkout
    @carrier_id = params_shopping_order[:carrier_id]
    # TODO check for empty cart.
    add_breadcrumb(Breadcrumb.new(url: shipping_method_customers_shopping_orders_path, name: 'Checkout'))
  end

  def addresses
    @variables ||= {}

    @type = params[:type]
    @variables['customer_addresses'] = current_customer.customer_addresses

    add_breadcrumb(Breadcrumb.new(url: shipping_method_customers_shopping_orders_path, name: 'Checkout'))
    add_breadcrumb(Breadcrumb.new(url: addresses_customers_shopping_orders_path(@type), name: 'Select address'))
  end

  # TODO change this event for post.
  # TODO check param type
  def save_address
    type = params[:type]
    id = params[:id].to_i

    addresses = current_customer.customer_addresses.pluck(:id)
    if addresses.include? id
      attributes = {}
      attributes[type] = id
      sc = current_customer.shopping_cart
      unless sc.nil?
        sc.attributes = attributes
        sc.save
      end
    end

    redirect_to :shipping_method_customers_shopping_orders
  end

  def save_carrier
    sc = current_customer.shopping_cart
    unless sc.nil?
      sc.attributes = params_shopping_order
      sc.save
    end

    redirect_to :checkout_customers_shopping_orders
  end

  def shipping_method
    @carriers = Carrier.where(enabled: true)
  end

  def finalize
    sc = current_customer.shopping_cart

    unless sc.nil?
      so = ShoppingOrder.from_shopping_cart(sc, @commerce)
      unless so.save
        redirect_to :shipping_method_customers_shopping_orders, alert: 'A carrier needs to be selected.'
        return
      end

      sc.destroy
    end

    redirect_to :show_customers, notice: 'Thanks for your purchase.'
  end

  protected

  def params_shopping_order
    params.permit(:carrier_id)
  end

  def set_breadcrumbs
    add_breadcrumb(Breadcrumb.new(url: show_customers_path, name: 'Customers'))
  end

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
