# == Schema Information
#
# Table name: shopping_orders_addresses
#
#  billing           :boolean          default(FALSE), not null
#  created_at        :datetime         not null
#  fields            :hstore           default({}), not null
#  id                :integer          not null, primary key
#  shipping          :boolean          default(FALSE), not null
#  shopping_order_id :integer
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_shopping_orders_addresses_on_shopping_order_id  (shopping_order_id)
#

class ShoppingOrdersAddress < ActiveRecord::Base
  belongs_to :shopping_order
end
