# == Schema Information
#
# Table name: products_pictures
#
#  created_at         :datetime         not null
#  id                 :integer          not null, primary key
#  image_content_type :string
#  image_file_name    :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  priority           :integer          default(1), not null
#  product_id         :integer
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_products_pictures_on_product_id  (product_id)
#

require 'test_helper'

class ProductsPictureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
