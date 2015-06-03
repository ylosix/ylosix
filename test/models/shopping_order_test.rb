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

require 'test_helper'

class ShoppingOrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
