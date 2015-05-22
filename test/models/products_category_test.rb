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
# Indexes
#
#  index_products_categories_on_category_id                 (category_id)
#  index_products_categories_on_category_id_and_product_id  (category_id,product_id)
#  index_products_categories_on_product_id                  (product_id)
#

require 'test_helper'

class ProductsCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
