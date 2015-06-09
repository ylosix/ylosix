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

class CustomerAddress < ActiveRecord::Base
end
