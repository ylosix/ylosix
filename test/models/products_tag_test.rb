# == Schema Information
#
# Table name: products_tags
#
#  id         :integer          not null, primary key
#  product_id :integer
#  tag_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ProductsTagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
