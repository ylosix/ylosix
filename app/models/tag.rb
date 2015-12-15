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

  default_scope { includes(:translations) }

  def to_liquid(options = {})
    current_ids = []
    current_ids = options[:current_tags][1] if options[:current_tags]

    include_ids = current_ids.dup
    include_ids.push(id) unless include_ids.include?(id)

    discard_ids = current_ids.dup
    discard_ids.delete(id)

    {
        'active' => current_ids.include?(id),
        'name' => name,
        'slug' => slug,
        'href' => retrieve_tags_path(include_ids, options[:current_category]),
        'remove_href' => retrieve_tags_path(discard_ids, options[:current_category]),
        'products_size' => products.size
    }
  end

  private

  def retrieve_tags_path(ids, category = nil)
    helpers = Rails.application.routes.url_helpers

    if category
      if ids.empty?
        helpers.category_path(category.slug)
      else
        helpers.category_tags_path(category.slug, ids)
      end
    else
      if ids.empty?
        helpers.root_path
      else
        helpers.tags_path(ids)
      end
    end
  end

  def set_defaults
    generate_slug(:name, tag_translations)
  end
end
