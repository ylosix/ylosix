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

class Category < ActiveRecord::Base
  translates :name

  has_many :children, class_name: 'Category', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Category'

  has_many :products_categories
  has_many :products, through: :products_categories
  has_many :category_translations

  accepts_nested_attributes_for :category_translations

  # TODO only enabled languages
  def admin_category_translations
    translations = []

    languages = Language.where(appears_in_backoffice: true)
    languages.each do |lang|
      ct = CategoryTranslation.find_by(locale: lang.code, category_id: id)
      ct = CategoryTranslation.new(locale: lang.code, category_id: id) if ct.nil?

      translations << ct
    end
    #
    # CategoryTranslation.find_by_sql("SELECT `ct`.* FROM `languages` as `lang`
    #       LEFT JOIN `category_translations` as `ct` ON
    #         `lang`.`code` = `ct`.`locale` and
    #         `ct`.`category_id` = #{id}")

    translations
  end

  def to_liquid
    {
      'name' => name,
      'href' => Rails.application.routes.url_helpers.show_slug_categories_path(slug),
      'children' => children
    }
  end
end
