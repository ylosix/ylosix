# == Schema Information
#
# Table name: products
#
#  appears_in_categories :boolean          default(TRUE)
#  appears_in_search     :boolean          default(TRUE)
#  appears_in_tag        :boolean          default(TRUE)
#  barcode               :string
#  control_stock         :boolean          default(FALSE)
#  created_at            :datetime
#  description           :text
#  enabled               :boolean          default(FALSE)
#  id                    :integer          not null, primary key
#  image_content_type    :string
#  image_file_name       :string
#  image_file_size       :integer
#  image_updated_at      :datetime
#  meta_description      :string
#  meta_keywords         :string
#  name                  :string
#  publication_date      :datetime         default(Thu, 01 Jan 2015 00:00:00 UTC +00:00), not null
#  reference_code        :string
#  retail_price          :decimal(10, 2)   default(0.0), not null
#  retail_price_pre_tax  :decimal(10, 5)   default(0.0), not null
#  short_description     :string
#  slug                  :string           not null
#  stock                 :integer          default(0)
#  tax_id                :integer
#  unpublication_date    :datetime
#  updated_at            :datetime
#
# Indexes
#
#  index_products_on_tax_id  (tax_id)
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'set_default_publication_date' do
    pr = Product.new
    pr.save

    assert !pr.publication_date.nil?
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
  end
end
