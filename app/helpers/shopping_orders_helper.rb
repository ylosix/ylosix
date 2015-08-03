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
