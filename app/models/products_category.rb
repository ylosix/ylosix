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

class ProductsCategory < ActiveRecord::Base
  belongs_to :product
  belongs_to :category
end
