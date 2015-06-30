# == Schema Information
#
# Table name: categories
#
#  created_at       :datetime         not null
#  enabled          :boolean          default(FALSE)
#  id               :integer          not null, primary key
#  meta_description :string
#  meta_keywords    :string
#  name             :string
#  parent_id        :integer
#  slug             :string
#  updated_at       :datetime         not null
#  visible          :boolean          default(TRUE)
#
# Indexes
#
#  index_categories_on_parent_id  (parent_id)
#  index_categories_on_slug       (slug)
#

class Category < ActiveRecord::Base
  include ArrayLiquid
  include InitializeSlug

  translates :name

  has_many :children, class_name: 'Category', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Category'

  has_many :products_categories
  has_many :products, through: :products_categories

  has_many :category_translations
  accepts_nested_attributes_for :category_translations

  has_many :tags_groups_categories
  has_many :tags_groups, through: :tags_groups_categories

  scope :are_enabled, -> { where(enabled: true) }
  scope :in_frontend, lambda {
                      where(enabled: true, visible: true)
                    }

  before_save :set_defaults

  def self.root_category
    Category.find_by(parent_id: [nil, 0],
                     visible: true,
                     enabled: true)
  end

  def self.root_categories
    root_category = Category.root_category

    root_categories = []
    unless root_category.nil?
      root_categories = root_category.children.in_frontend
    end

    root_categories
  end

  def to_liquid
    {
        'name' => name,
        'href' => Rails.application.routes.url_helpers.show_slug_categories_path(slug),
        'children' => array_to_liquid(children)
    }
  end

  private

  def set_defaults
    if slug.blank?
      self.slug = generate_slug(name, category_translations, :name)
    else
      self.slug = parse_url_chars(slug)
    end
  end
end
