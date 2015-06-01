# == Schema Information
#
# Table name: products
#
#  id                    :integer          not null, primary key
#  reference_code        :string
#  name                  :string
#  barcode               :string
#  enabled               :boolean          default(FALSE)
#  appears_in_categories :boolean          default(TRUE)
#  appears_in_tag        :boolean          default(TRUE)
#  appears_in_search     :boolean          default(TRUE)
#  short_description     :string
#  description           :text
#  publication_date      :datetime         default(Thu, 01 Jan 2015 00:00:00 UTC +00:00), not null
#  unpublication_date    :datetime
#  retail_price_pre_tax  :decimal(10, 5)
#  retail_price          :decimal(10, 2)
#  tax_id                :integer
#  meta_keywords         :string
#  meta_description      :string
#  slug                  :string
#  stock                 :integer          default(0)
#  control_stock         :boolean          default(FALSE)
#  created_at            :datetime
#  updated_at            :datetime
#  image_file_name       :string
#  image_content_type    :string
#  image_file_size       :integer
#  image_updated_at      :datetime
#
# Indexes
#
#  index_products_on_tax_id  (tax_id)
#

class Product < ActiveRecord::Base
  translates :name, :short_description, :description
  has_attached_file :image, styles: {medium: '300x300>', thumb: '100x100>'}

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :tax
  has_many :products_categories
  has_many :categories, through: :products_categories

  has_many :products_tags
  has_many :tags, through: :products_tags

  has_many :product_translations
  has_many :shopping_carts_products

  accepts_nested_attributes_for :products_categories, allow_destroy: true
  accepts_nested_attributes_for :products_tags, allow_destroy: true
  accepts_nested_attributes_for :product_translations

  before_create :set_default_publication_date

  scope :search_by_text, lambda { |text|
                         joins(:product_translations)
                             .where('product_translations.name LIKE ? OR product_translations.description LIKE ?', "%#{text}%", "%#{text}%")
                       }

  scope :in_frontend, lambda { |category|
                      joins(:products_categories)
                          .where(products_categories: {category_id: category.id},
                                 appears_in_categories: true)
                          .where('publication_date >= ?', DateTime.now)
                    }

  def admin_translations
    Utils.array_translations(ProductTranslation, product_id: id)
  end

  def clone
    product = dup
    # TODO: need to fix nested attributes.
    # product.products_tags = self.products_tags
    # product.products_categories = self.products_categories

    product
  end

  def to_liquid
    helpers = Rails.application.routes.url_helpers
    image_src = 'http://placehold.it/320x150'
    image_src = image.url(:medium) if image.file?

    s_short_description = ''
    s_short_description = short_description.html_safe unless short_description.blank?

    s_description = ''
    s_description = description.html_safe unless description.blank?

    {
        'name' => name,
        'short_description' => s_short_description,
        'description' => s_description,
        'retail_price' => retail_price,
        'image_src' => image_src,
        'href' => helpers.show_slug_products_path(slug),
        'buy_href' => helpers.add_to_shopping_cart_products_path(self)
    }
  end

  private

  def set_default_publication_date
    self.publication_date = Time.now
  end
end
