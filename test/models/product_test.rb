# == Schema Information
#
# Table name: products
#
#  id                    :integer          not null, primary key
#  reference_code        :string
#  name                  :string
#  barcode               :string
#  enabled               :boolean
#  appears_in_categories :boolean
#  appears_in_tag        :boolean
#  appears_in_search     :boolean
#  short_description     :string
#  description           :text
#  publication_date      :datetime
#  unpublication_date    :datetime
#  retail_price_pre_tax  :decimal(10, 5)
#  retail_price          :decimal(10, 2)
#  tax_percent           :decimal(3, 2)
#  meta_title            :string
#  meta_description      :string
#  slug                  :string
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
