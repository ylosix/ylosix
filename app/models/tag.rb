# == Schema Information
#
# Table name: tags
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string
#  parent_id  :integer
#  priority   :integer          default(1)
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_parent_id  (parent_id)
#

class Tag < ActiveRecord::Base
  translates :name

  has_many :children, class_name: 'Tag', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Tag'

  has_many :products_tags
  has_many :products, through: :products_tags

  has_many :tag_translations
  accepts_nested_attributes_for :tag_translations

  scope :root_tags, -> { where(parent_id: nil) }
end
