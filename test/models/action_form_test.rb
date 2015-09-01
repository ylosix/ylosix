# == Schema Information
#
# Table name: action_forms
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  mapping    :hstore           default({}), not null
#  tag        :string
#  updated_at :datetime         not null
#

require 'test_helper'

class ActionFormTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
