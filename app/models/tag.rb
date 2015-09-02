# == Schema Information
#
# Table name: tags
#
#  created_at    :datetime         not null
#  id            :integer          not null, primary key
#  name          :string
#  priority      :integer          default(1), not null
#  tags_group_id :integer
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_tags_on_tags_group_id  (tags_group_id)
#

class Tag < ActiveRecord::Base
  include InitializeSlug
  attr_accessor :href, :remove_href
  translates :name, :slug

  belongs_to :tags_group
  has_many :products_tags
  has_many :products, through: :products_tags

  has_many :tag_translations
  accepts_nested_attributes_for :tag_translations

  before_save :set_defaults

  def to_liquid
    {
        'name' => name,
        'slug' => slug,
        'href' => href,
        'remove_href' => remove_href
    }
  end

  private

  def set_defaults
    generate_slug(:name, tag_translations)
  end
end
