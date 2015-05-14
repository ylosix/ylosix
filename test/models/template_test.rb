# == Schema Information
#
# Table name: templates
#
#  id         :integer          not null, primary key
#  name       :string
#  path       :string
#  enabled    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TemplateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
