# == Schema Information
#
# Table name: products
#
#  barcode              :string
#  control_stock        :boolean          default(FALSE)
#  created_at           :datetime
#  depth                :decimal(10, 6)   default(0.0), not null
#  description          :text
#  enabled              :boolean          default(FALSE)
#  height               :decimal(10, 6)   default(0.0), not null
#  id                   :integer          not null, primary key
#  image_content_type   :string
#  image_file_name      :string
#  image_file_size      :integer
#  image_updated_at     :datetime
#  meta_description     :string
#  meta_keywords        :string
#  name                 :string
#  publication_date     :datetime         default(Thu, 01 Jan 2015 00:00:00 UTC +00:00), not null
#  reference_code       :string
#  retail_price         :decimal(10, 2)   default(0.0), not null
#  retail_price_pre_tax :decimal(10, 5)   default(0.0), not null
#  short_description    :string
#  show_action_name     :string
#  stock                :integer          default(0)
#  tax_id               :integer
#  unpublication_date   :datetime
#  updated_at           :datetime
#  visible              :boolean          default(TRUE)
#  weight               :decimal(10, 6)   default(0.0), not null
#  width                :decimal(10, 6)   default(0.0), not null
#
# Indexes
#
#  index_products_on_tax_id  (tax_id)
#
# Foreign Keys
#
#  fk_rails_f5661f270e  (tax_id => taxes.id)
#

class Product < ActiveRecord::Base
  include InitializeSlug
  IMAGE_SIZES = {thumbnail: 'x100', small: 'x300', medium: 'x500', original: 'x720'}

  translates :name, :short_description, :description, :features, :slug
  has_attached_file :image, styles: IMAGE_SIZES

  validates_attachment_size :image, less_than: 2.megabytes
  validates_attachment_content_type :image, content_type: %r{\Aimage/.*\Z}

  belongs_to :tax
  has_many :products_categories
  has_many :categories, through: :products_categories

  has_many :products_tags
  has_many :tags, through: :products_tags
  has_many :products_pictures

  has_many :product_translations
  has_many :shopping_carts_products

  accepts_nested_attributes_for :products_categories, allow_destroy: true
  accepts_nested_attributes_for :products_tags, allow_destroy: true
  accepts_nested_attributes_for :products_pictures, allow_destroy: true
  accepts_nested_attributes_for :product_translations

  before_save :set_defaults

  scope :search_by_text, lambda { |text|
                         joins(:product_translations)
                             .where(visible: true)
                             .where('publication_date <= ?', DateTime.now)
                             .where('unpublication_date is null or unpublication_date >= ?', DateTime.now)
                             .where('LOWER(product_translations.name) LIKE LOWER(?)
                                      OR LOWER(product_translations.description) LIKE LOWER(?)',
                                    "%#{text}%", "%#{text}%").group('products.id')
                       }

  def self.in_frontend(category, not_in_list = [])
    products = Product.joins(:products_categories)

    products = products.where('products.id not in (?)', not_in_list) if not_in_list.any?
    products = products.where('publication_date <= ?', DateTime.now)
                   .where('unpublication_date is null or unpublication_date >= ?', DateTime.now)
                   .where(products_categories:
                              {category_id: category.id},
                          visible: true)
                   .group('products.id')

    category.children.each do |child|
      products += Product.in_frontend(child, products.map(&:id))
    end

    products
  end

  def clone
    product = dup
    # TODO: need to fix nested attributes.
    # product.products_tags = self.products_tags
    # product.products_categories = self.products_categories

    product
  end

  def retrieve_main_image(type = :original)
    image_src = 'http://placehold.it/650x500'

    # TODO add fixed sizes as small, large, original, etc.
    case type
      when :thumbnail
        image_src = 'http://placehold.it/130x100'
      when :small
        image_src = 'http://placehold.it/390x300'
      when :medium
        image_src = 'http://placehold.it/650x500'
    end

    image_src = image.url(type) if image?
    image_src
  end

  def href
    slug_to_href(self)
  end

  def to_liquid
    helpers = Rails.application.routes.url_helpers
    s_short_description = ''
    s_short_description = short_description.html_safe unless short_description.blank?

    s_description = ''
    s_description = description.html_safe unless description.blank?

    liquid = {
        'name' => name,
        'short_description' => s_short_description,
        'description' => s_description,
        'retail_price' => retail_price,
        'href' => href,
        'add_cart_href' => helpers.add_to_shopping_cart_products_path(self),
        'delete_cart_href' => helpers.delete_from_shopping_cart_products_path(self)
    }

    append_images(liquid)
  end

  def replace_keys_features
    hash_features = {}

    unless features.blank?
      features.each do |k, v|
        f = Feature.find_by(id: k)
        hash_features[f.name] = v unless f.nil?
      end
    end

    self.features = hash_features
  end

  private

  def append_images(hash)
    IMAGE_SIZES.each do |size, _k|
      hash["image_#{size}_src"] = retrieve_main_image(size)
    end

    if products_pictures.any?
      hash['products_pictures'] = []

      products_pictures.each do |picture|
        hash['products_pictures'] << picture.append_images
      end
    end

    hash
  end

  def set_defaults
    self.publication_date ||= Time.now

    generate_slug(:name, product_translations)
  end
end
