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

class ProductsPicture < ActiveRecord::Base
  belongs_to :product
  has_attached_file :image, styles: Product::IMAGE_SIZES

  validates_attachment_size :image, less_than: 2.megabytes
  validates_attachment_content_type :image, content_type: %r{\Aimage/.*\Z}

  def retrieve_main_image(type = :original)
    image_src = 'http://placehold.it/650x500'

    # TODO add fixed sizes as small, large, original, etc.
    case type
      when :thumbnail
        image_src = 'http://placehold.it/130x100'
      when :small
        image_src = 'http://placehold.it/390x300'
      when :medium
        image_src = 'http://placehold.it/650x500'
    end

    image_src = image.url(type) if image?
    image_src
  end

  def append_images
    hash = {}
    Product::IMAGE_SIZES.each do |size, _k|
      hash["image_#{size}_src"] = retrieve_main_image(size)
    end

    hash
  end
end
