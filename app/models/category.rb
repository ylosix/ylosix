# == Schema Information
#
# Table name: categories
#
#  id               :integer          not null, primary key
#  parent_id        :integer
#  name             :string
#  enabled          :boolean          default(FALSE)
#  appears_in_web   :boolean          default(TRUE)
#  meta_keywords    :string
#  meta_description :string
#  slug             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_categories_on_parent_id  (parent_id)
#  index_categories_on_slug       (slug)
#

class Category < ActiveRecord::Base
  include LiquidExtension

  translates :name

  has_many :children, class_name: 'Category', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Category'

  has_many :products_categories
  has_many :products, through: :products_categories
  has_many :category_translations

  accepts_nested_attributes_for :category_translations

  scope :are_enabled, -> { where(enabled: true) }
  scope :in_frontend, lambda {
                      where(enabled: true, appears_in_web: true)
                    }

  before_save :set_defaults

  def self.root_category
    Category.find_by(parent_id: [nil, 0],
                     appears_in_web: true,
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
      self.slug = 'needs-to-be-changed'
      if !name.blank?
        self.slug = URI.encode(name)
      elsif category_translations.any? && !category_translations.first.name.blank?
        self.slug = URI.encode(category_translations.first.name)
      end
    end
  end
end
