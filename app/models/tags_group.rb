# == Schema Information
#
# Table name: tags_groups
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string
#  updated_at :datetime         not null
#

class TagsGroup < ActiveRecord::Base
  translates :name

  has_many :tags_group_translations
  accepts_nested_attributes_for :tags_group_translations

  has_many :tags_groups_categories
  has_many :categories, through: :tags_groups_categories
  accepts_nested_attributes_for :tags_groups_categories, allow_destroy: true
end
