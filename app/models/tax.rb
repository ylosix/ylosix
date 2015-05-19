# == Schema Information
#
# Table name: taxes
#
#  id         :integer          not null, primary key
#  name       :string
#  rate       :decimal(5, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tax < ActiveRecord::Base
  has_many :products
end
