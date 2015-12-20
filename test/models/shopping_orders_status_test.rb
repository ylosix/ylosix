# == Schema Information
#
# Table name: shopping_orders_statuses
#
#  color             :string
#  created_at        :datetime         not null
#  enable_invoice    :boolean
#  id                :integer          not null, primary key
#  name_translations :hstore           default({}), not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class ShoppingOrdersStatusTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
