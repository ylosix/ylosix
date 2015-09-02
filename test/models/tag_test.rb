# == Schema Information
#
# Table name: tags
#
#  created_at    :datetime         not null
#  id            :integer          not null, primary key
#  name          :string
#  priority      :integer          default(1), not null
#  tags_group_id :integer
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_tags_on_tags_group_id  (tags_group_id)
#

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test 'to_liquid' do
    hash = tags(:cameras).to_liquid

    assert hash.key? 'name'
    assert hash.key? 'slug'
    assert hash.key? 'href'
    assert hash.key? 'remove_href'
  end
end
