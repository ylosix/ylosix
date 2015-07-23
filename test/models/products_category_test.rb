# == Schema Information
#
# Table name: products_categories
#
#  category_id :integer
#  created_at  :datetime         not null
#  id          :integer          not null, primary key
#  product_id  :integer
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_products_categories_on_category_id                 (category_id)
#  index_products_categories_on_category_id_and_product_id  (category_id,product_id)
#  index_products_categories_on_product_id                  (product_id)
#
# Foreign Keys
#
#  fk_rails_a1ce5a7e88  (category_id => categories.id)
#  fk_rails_cd4212db90  (product_id => products.id)
#

require 'test_helper'

class ProductsCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
