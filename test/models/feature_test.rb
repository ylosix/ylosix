# == Schema Information
#
# Table name: features
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string
#  priority   :integer          default(1), not null
#  updated_at :datetime         not null
#

require 'test_helper'

class FeatureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
