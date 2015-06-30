# == Schema Information
#
# Table name: tags
#
#  created_at    :datetime         not null
#  id            :integer          not null, primary key
#  name          :string
#  priority      :integer          default(1)
#  slug          :string
#  tags_group_id :integer
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_tags_on_tags_group_id  (tags_group_id)
#

require 'test_helper'

class TagTest < ActiveSupport::TestCase
end
