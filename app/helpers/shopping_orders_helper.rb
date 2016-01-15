# == Schema Information
#
# Table name: shopping_orders
#
#  billing_address           :hstore           default({}), not null
#  billing_commerce          :hstore           default({}), not null
#  carrier_id                :integer
#  carrier_retail_price      :decimal(10, 2)   default(0.0), not null
#  commerce_id               :integer
#  created_at                :datetime         not null
#  customer_id               :integer
#  extra_fields              :hstore           default({}), not null
#  id                        :integer          not null, primary key
#  order_num                 :integer          not null
#  shipping_address          :hstore           default({}), not null
#  shopping_orders_status_id :integer
#  updated_at                :datetime         not null
#
# Indexes
#
#  index_shopping_orders_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_6cc7143c73  (customer_id => customers.id)
#  fk_rails_be0697c8ed  (commerce_id => commerces.id)
#  fk_rails_c71875ef4e  (carrier_id => carriers.id)
#

module ShoppingOrdersHelper
  def shopping_order_status(so)
    color = ''
    status = 'Pending'

    unless so.shopping_orders_status.nil?
      color = so.shopping_orders_status.color
      status = so.shopping_orders_status.name
    end

    content_tag :div do
      concat(content_tag(:label, 'STATUS'))
      concat('<br />'.html_safe)
      concat(content_tag(:span, status, class: 'status_tag', style: "background-color: #{color};"))
    end
  end
end
