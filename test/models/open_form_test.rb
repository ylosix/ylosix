# == Schema Information
#
# Table name: open_forms
#
#  created_at :datetime         not null
#  fields     :hstore           default({}), not null
#  id         :integer          not null, primary key
#  tag        :string
#  updated_at :datetime         not null
#

require 'test_helper'

class OpenFormTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
