# == Schema Information
#
# Table name: tags
#
#  id             :integer          not null, primary key
#  name           :string
#  parent_id      :integer
#  priority       :integer          default(1)
#  appears_in_web :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_tags_on_parent_id  (parent_id)
#

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test 'get_parents_array' do
    array = Utils.get_parents_array(tags(:cameras))
    assert array.empty?

    array = Utils.get_parents_array(tags(:reflex))
    assert array.length == 1
  end
end
