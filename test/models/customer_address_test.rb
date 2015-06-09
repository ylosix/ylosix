# == Schema Information
#
# Table name: customer_addresses
#
#  created_at :datetime         not null
#  fields     :hstore           default({}), not null
#  id         :integer          not null, primary key
#  name       :string
#  updated_at :datetime         not null
#

require 'test_helper'

class CustomerAddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
