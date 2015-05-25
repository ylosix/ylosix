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
  translates :name

  has_many :children, class_name: 'Category', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Category'

  has_many :products_categories
  has_many :products, through: :products_categories
  has_many :category_translations

  accepts_nested_attributes_for :category_translations

  scope :in_frontend, lambda {
                      where(enabled: true,
                            appears_in_web: true)
                    }

  scope :root_category, lambda {
                        find_by(parent_id: [nil, 0],
                                appears_in_web: true,
                                enabled: true)
                      }

  def admin_translations
    Utils.array_translations(CategoryTranslation, category_id: id)
  end

  def to_liquid
    {
        'name' => name,
        'href' => Rails.application.routes.url_helpers.show_slug_categories_path(slug),
        'children' => children
    }
  end
end
