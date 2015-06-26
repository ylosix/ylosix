# == Schema Information
#
# Table name: tags
#
#  created_at    :datetime         not null
#  id            :integer          not null, primary key
#  name          :string
#  priority      :integer          default(1)
#  tags_group_id :integer
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_tags_on_tags_group_id  (tags_group_id)
#

class Tag < ActiveRecord::Base
  translates :name

  belongs_to :tags_group
  has_many :products_tags
  has_many :products, through: :products_tags

  has_many :tag_translations
  accepts_nested_attributes_for :tag_translations

  def to_liquid
  end
end
