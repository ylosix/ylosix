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
