# == Schema Information
#
# Table name: languages
#
#  id                    :integer          not null, primary key
#  code                  :string
#  flag                  :string
#  appears_in_backoffice :boolean
#  appears_in_web        :boolean
#  created_at            :datetime
#  updated_at            :datetime
#

require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
