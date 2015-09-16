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
#  priority         :integer          default(1), not null
#  reference_code   :string
#  show_action_name :string
#  updated_at       :datetime         not null
#  visible          :boolean          default(TRUE)
#
# Indexes
#
#  index_categories_on_parent_id       (parent_id)
#  index_categories_on_reference_code  (reference_code)
#

class Category < ActiveRecord::Base
  include ArrayLiquid
  include InitializeSlug

  translates :name, :short_description, :description, :slug

  # TODO put children in schema erd!
  # has_many :children, class_name: 'Category', foreign_key: 'parent_id'
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
                          .order(:priority)
                    }

  before_save :set_defaults

  def children
    children = Category.in_frontend.where(parent_id: id)
    children.to_a.sort! do |a, b|
      if a.priority == b.priority
        a.name.downcase <=> b.name.downcase
      else
        a.priority <=> b.priority
      end
    end
  end

  def self.root_category
    Category.in_frontend.find_by(parent_id: [nil, 0])
  end

  def self.root_categories
    root_category = Category.root_category

    root_categories = []
    root_categories = root_category.children unless root_category.nil?

    root_categories
  end

  def href
    slug_to_href(self)
  end

  def to_liquid
    {
        'name' => name,
        'short_description' => short_description,
        'description' => description,
        'priority' => priority,
        'href' => href,
        'children' => array_to_liquid(children)
    }
  end

  private

  def set_defaults
    generate_slug(:name, category_translations)
  end
end
