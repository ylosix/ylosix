# == Schema Information
#
# Table name: products
#
#  barcode                        :string
#  control_stock                  :boolean          default(FALSE)
#  created_at                     :datetime
#  depth                          :decimal(10, 6)   default(0.0), not null
#  description_translations       :hstore           default({}), not null
#  enabled                        :boolean          default(FALSE)
#  features_translations          :hstore           default({}), not null
#  height                         :decimal(10, 6)   default(0.0), not null
#  href_translations              :hstore           default({}), not null
#  id                             :integer          not null, primary key
#  image_content_type             :string
#  image_file_name                :string
#  image_file_size                :integer
#  image_updated_at               :datetime
#  meta_tags_translations         :hstore           default({}), not null
#  name_translations              :hstore           default({}), not null
#  publication_date               :datetime         not null
#  reference_code                 :string
#  retail_price                   :decimal(10, 2)   default(0.0), not null
#  retail_price_pre_tax           :decimal(10, 5)   default(0.0), not null
#  short_description_translations :hstore           default({}), not null
#  show_action_name               :string
#  slug_translations              :hstore           default({}), not null
#  stock                          :integer          default(0)
#  tax_id                         :integer
#  unpublication_date             :datetime
#  updated_at                     :datetime
#  visible                        :boolean          default(TRUE)
#  weight                         :decimal(10, 6)   default(0.0), not null
#  width                          :decimal(10, 6)   default(0.0), not null
#
# Indexes
#
#  index_products_on_enabled  (enabled)
#  index_products_on_tax_id   (tax_id)
#  index_products_on_visible  (visible)
#
# Foreign Keys
#
#  fk_rails_f5661f270e  (tax_id => taxes.id)
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'set_defaults' do
    pr = Product.new(name_translations: {en: 'potato with spaces'})
    assert pr.save
    assert !pr.publication_date.blank?

    pr.slug_translations.each do |_k, v|
      assert !v.blank?
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

  test 'array_features' do
    product = products(:camera)
    assert product.array_features.class == Array
  end
end
