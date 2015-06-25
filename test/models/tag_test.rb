# == Schema Information
#
# Table name: tags
#
#  created_at    :datetime         not null
#  id            :integer          not null, primary key
#  name          :string
#  priority      :integer          default(1)
#  tags_group_id :integer
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_tags_on_tags_group_id  (tags_group_id)
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
