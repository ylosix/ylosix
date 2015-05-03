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

  test 'get_parents_array' do
    array = categories(:root).get_parents_array
    assert array.empty?

    array = categories(:digital_cameras).get_parents_array
    assert array.length == 1
  end

end
