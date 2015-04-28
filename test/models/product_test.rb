# == Schema Information
#
# Table name: products
#
#  id                    :integer          not null, primary key
#  reference_code        :string(255)
#  name                  :string(255)
#  barcode               :string(255)
#  enabled               :boolean
#  appears_in_categories :boolean
#  appears_in_tag        :boolean
#  appears_in_search     :boolean
#  short_description     :string(255)
#  description           :string(255)
#  publication_date      :datetime
#  unpublication_date    :datetime
#  retail_price_pre_tax  :decimal(10, 5)
#  retail_price          :decimal(10, 2)
#  tax_percent           :decimal(3, 2)
#  meta_title            :string(255)
#  meta_description      :string(255)
#  slug                  :string(255)
#  stock                 :integer
#  control_stock         :boolean
#  created_at            :datetime
#  updated_at            :datetime
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
