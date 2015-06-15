# == Schema Information
#
# Table name: products_tags
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  product_id :uuid
#  tag_id     :integer
#  updated_at :datetime         not null
#
# Indexes
#
#  index_products_tags_on_product_id             (product_id)
#  index_products_tags_on_tag_id                 (tag_id)
#  index_products_tags_on_tag_id_and_product_id  (tag_id,product_id)
#

require 'test_helper'

class ProductsTagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
