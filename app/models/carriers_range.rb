# == Schema Information
#
# Table name: carriers_ranges
#
#  amount             :decimal(, )
#  carrier_id         :integer
#  created_at         :datetime         not null
#  greater_equal_than :decimal(, )
#  id                 :integer          not null, primary key
#  lower_than         :decimal(, )
#  updated_at         :datetime         not null
#  zone_id            :integer
#
# Indexes
#
#  index_carriers_ranges_on_carrier_id  (carrier_id)
#  index_carriers_ranges_on_zone_id     (zone_id)
#

class CarriersRange < ActiveRecord::Base
  belongs_to :zone
  belongs_to :carrier
end
