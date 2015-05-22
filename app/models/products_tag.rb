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
# Indexes
#
#  index_products_tags_on_product_id             (product_id)
#  index_products_tags_on_tag_id                 (tag_id)
#  index_products_tags_on_tag_id_and_product_id  (tag_id,product_id)
#

class ProductsTag < ActiveRecord::Base
  belongs_to :product
  belongs_to :tag
end
