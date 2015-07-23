# == Schema Information
#
# Table name: products_tags
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  product_id :integer
#  tag_id     :integer
#  updated_at :datetime         not null
#
# Indexes
#
#  index_products_tags_on_product_id             (product_id)
#  index_products_tags_on_tag_id                 (tag_id)
#  index_products_tags_on_tag_id_and_product_id  (tag_id,product_id)
#
# Foreign Keys
#
#  fk_rails_5967ba3ad6  (tag_id => tags.id)
#  fk_rails_a039dcf9ff  (product_id => products.id)
#

require 'test_helper'

class ProductsTagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
