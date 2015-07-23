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
# Foreign Keys
#
#  fk_rails_6f2fb9f3e1  (product_id => products.id)
#

require 'test_helper'

class ProductsPictureTest < ActiveSupport::TestCase
  test 'retrieve pictures' do
    pic = products_pictures(:one)
    Product::IMAGE_SIZES.each do |k, _v|
      assert !pic.retrieve_main_image(k.to_sym).blank?
    end
  end

  test 'append images' do
    pic = products_pictures(:one)
    hash = pic.append_images

    assert !hash.empty?
  end
end
