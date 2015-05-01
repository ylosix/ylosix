# == Schema Information
#
# Table name: categories
#
#  id               :integer          not null, primary key
#  parent_id        :integer
#  name             :string
#  appears_in_web   :boolean
#  meta_title       :string
#  meta_description :string
#  slug             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
