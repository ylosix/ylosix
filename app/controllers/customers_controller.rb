# == Schema Information
#
# Table name: customers
#
#  birth_date             :date
#  created_at             :datetime         not null
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  enabled                :boolean
#  encrypted_password     :string           default(""), not null
#  id                     :integer          not null, primary key
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locale                 :string           default("en"), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_customers_on_email                 (email) UNIQUE
#  index_customers_on_reset_password_token  (reset_password_token) UNIQUE
#

class CustomersController < Frontend::CommonController
  before_action :authenticate_customer!

  def append_variables
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
