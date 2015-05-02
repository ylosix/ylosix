# == Schema Information
#
# Table name: categories
#
#  id               :integer          not null, primary key
#  parent_id        :integer
#  name             :string
#  appears_in_web   :boolean
#  meta_title       :string
#  meta_description :string
#  slug             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Category < ActiveRecord::Base
  has_many :children, :class_name => 'Category', :foreign_key => 'parent_id'
  belongs_to :parent, :class_name => 'Category'

  has_many :products_categories
  has_many :products, :through => :products_categories
end
