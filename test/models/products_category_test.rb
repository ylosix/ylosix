# == Schema Information
#
# Table name: products_categories
#
#  id          :integer          not null, primary key
#  product_id  :integer
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ProductsCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
