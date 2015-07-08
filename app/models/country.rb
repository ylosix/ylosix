# == Schema Information
#
# Table name: countries
#
#  code       :string
#  created_at :datetime         not null
#  enabled    :boolean          default(FALSE), not null
#  id         :integer          not null, primary key
#  iso        :string
#  name       :string
#  updated_at :datetime         not null
#  zone_id    :integer
#
# Indexes
#
#  index_countries_on_zone_id  (zone_id)
#

class Country < ActiveRecord::Base
  belongs_to :zone

  def to_liquid
    {
        'code' => code,
        'name' => name,
        'iso' => iso
    }
  end
end
