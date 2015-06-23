class CustomersController < Frontend::CommonController
  before_action :authenticate_customer!

  def get_template_variables(template)
    super

    @variables['shopping_orders'] = []

    if customer_signed_in?
      @variables['shopping_orders'] = current_customer.shopping_orders.order('created_at DESC')
    end
  end

  def show
  end

  def orders
    add_breadcrumb(Breadcrumb.new(url: orders_customers_path, name: 'Orders'))
  end

  def invoice
    order_id = params[:id].to_i
    unless current_customer.shopping_orders.pluck(:id).include? order_id
      redirect_to :show_customers, alert: "The order doesn't exist"
    end

    shopping_order = current_customer.shopping_orders.find_by(id: order_id)
    render layout: '/layouts/invoice', partial: '/shopping_orders/invoice', locals: {shopping_order: shopping_order}
  end

  protected

  def set_breadcrumbs
    add_breadcrumb(Breadcrumb.new(url: show_customers_path, name: 'Customers'))
  end
end
