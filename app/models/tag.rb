# == Schema Information
#
# Table name: tags
#
#  id             :integer          not null, primary key
#  name           :string
#  parent_id      :integer
#  priority       :integer          default(1)
#  appears_in_web :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Tag < ActiveRecord::Base
  has_many :children, class_name: 'Tag', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Tag'

  has_many :products_tags
  has_many :products, through: :products_tags
end
