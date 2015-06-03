# == Schema Information
#
# Table name: shopping_orders
#
#  created_at  :datetime         not null
#  customer_id :integer
#  id          :integer          not null, primary key
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_shopping_orders_on_customer_id  (customer_id)
#

class ShoppingOrder < ActiveRecord::Base
  belongs_to :customer
end
