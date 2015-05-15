# == Schema Information
#
# Table name: categories
#
#  id               :integer          not null, primary key
#  parent_id        :integer
#  name             :string
#  enabled          :boolean          default(FALSE)
#  appears_in_web   :boolean          default(TRUE)
#  meta_keywords    :string
#  meta_description :string
#  slug             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'get_parents_array' do
    array = Utils.get_parents_array(categories(:root))
    assert array.empty?

    array = Utils.get_parents_array(categories(:digital_cameras))
    assert array.length == 1
  end

  test 'to_liquid' do
    hash = categories(:digital_cameras).to_liquid

    assert hash.key? 'name'
    assert hash.key? 'href'
    assert hash.key? 'children'
  end
end
