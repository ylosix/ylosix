# == Schema Information
#
# Table name: commerces
#
#  billing_address   :hstore
#  created_at        :datetime         not null
#  default           :boolean
#  ga_account_id     :string
#  http              :string
#  id                :integer          not null, primary key
#  logo_content_type :string
#  logo_file_name    :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  meta_description  :string
#  meta_keywords     :string
#  name              :string
#  template_id       :integer
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_commerces_on_template_id  (template_id)
#

require 'test_helper'

class CommerceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
