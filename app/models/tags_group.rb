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
  include ArrayLiquid
  translates :name

  has_many :tags
  has_many :tags_group_translations
  accepts_nested_attributes_for :tags_group_translations

  has_many :tags_groups_categories
  has_many :categories, through: :tags_groups_categories
  accepts_nested_attributes_for :tags_groups_categories, allow_destroy: true

  default_scope { includes(:translations) }

  def self.retrieve_groups(category_id = nil)
    list = []
    if category_id.nil?
      ids = TagsGroupsCategory.all.pluck(:tags_group_id)
      if ids.empty?
        list = TagsGroup.all
      else
        list = TagsGroup.where('id not in (?)', ids)
      end
    else
      list = TagsGroup.joins(:tags_groups_categories).where(tags_groups_categories: {category_id: category_id})
      list = TagsGroup.retrieve_groups if list.empty?
    end

    list
  end

  def to_liquid(options = {})
    {
        'name' => name,
        'tags' => array_to_liquid(retrieve_tags(options))
    }
  end

  def retrieve_tags(options)
    tags.map do |tag|
      tag.to_liquid(options)
    end
  end
end
