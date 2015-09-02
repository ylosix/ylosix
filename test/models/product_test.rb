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

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'set_defaults' do
    pr = Product.new(name: 'potato with spaces')
    assert pr.save
    assert !pr.publication_date.blank?

    pr.product_translations.each do |translation|
      assert !translation.slug.blank?
    end

    pt = ProductTranslation.new(name: 'potato with spaces', locale: :en)
    pr = Product.new(product_translations: [pt])
    assert pr.save

    pr.product_translations.each do |translation|
      assert !translation.slug.blank?
    end
  end

  test 'clone' do
    pr = Product.new
    pr.save

    pr_cloned = pr.clone
    assert pr_cloned.instance_of? Product
  end

  test 'to_liquid' do
    hash = products(:camera).to_liquid

    assert hash.key? 'name'
    assert hash.key? 'href'

    Product::IMAGE_SIZES.each do |size, _k|
      assert hash.key? "image_#{size}_src"
    end
  end
end
