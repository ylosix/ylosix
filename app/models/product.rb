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
#  tax_percent           :decimal(5, 2)
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

class Product < ActiveRecord::Base
  has_attached_file :image, styles: {medium: '300x300>', thumb: '100x100>'},
                    override_permissions: false

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  has_many :products_categories
  has_many :categories, through: :products_categories

  accepts_nested_attributes_for :products_categories, allow_destroy: true

  has_many :products_tags
  has_many :tags, through: :products_tags

  accepts_nested_attributes_for :products_tags, allow_destroy: true


  before_create :set_default_publication_date

  scope :search_by_text, ->(text) { 
    where("products.name LIKE ? OR products.description LIKE ?", "%#{text}%", "%#{text}%") 
  } 

  def clone
    product = self.dup
    # TODO need to fix nested attributes.
    # product.products_tags = self.products_tags
    # product.products_categories = self.products_categories

    product
  end

  private

  def set_default_publication_date
    self.publication_date = Time.now
  end
end
