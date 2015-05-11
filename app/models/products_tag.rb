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

class ProductsTag < ActiveRecord::Base
  belongs_to :product
  belongs_to :tag
end
