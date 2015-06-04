class CustomersController < Frontend::CommonController
  before_action :authenticate_customer!
  before_action :set_customer

  def get_template_variables(template)
    super

    @variables['shopping_orders'] = []

    if customer_signed_in?
      @variables['shopping_orders'] = current_customer.shopping_orders
    end
  end

  def show
  end

  def orders
  end

  private

  def set_customer
    @customer = current_customer
  end
end
