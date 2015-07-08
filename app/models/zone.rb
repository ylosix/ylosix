# == Schema Information
#
# Table name: zones
#
#  code       :string
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string
#  updated_at :datetime         not null
#

class Zone < ActiveRecord::Base
end
