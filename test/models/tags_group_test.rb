# == Schema Information
#
# Table name: tags_groups
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string
#  updated_at :datetime         not null
#

require 'test_helper'

class TagsGroupTest < ActiveSupport::TestCase
  test 'to_liquid' do
    hash = tags_groups(:one).to_liquid

    assert hash.key? 'name'
    assert hash.key? 'tags'
  end
end
