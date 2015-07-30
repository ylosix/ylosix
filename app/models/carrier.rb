# == Schema Information
#
# Table name: carriers
#
#  created_at         :datetime         not null
#  delay              :string
#  enabled            :boolean          default(FALSE), not null
#  free_carrier       :boolean          default(FALSE), not null
#  id                 :integer          not null, primary key
#  image_content_type :string
#  image_file_name    :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  name               :string
#  priority           :integer          default(1), not null
#  updated_at         :datetime         not null
#

class Carrier < ActiveRecord::Base
  translates :name, :delay

  has_many :carrier_translations
  accepts_nested_attributes_for :carrier_translations

  has_attached_file :image, styles: { original: '25x25' }
  validates_attachment_content_type :image, content_type: %r{\Aimage/.*\Z}

  def calculate_shipping_cost_to(country_code, weight = 0)
    country = Country.find_by(code: country_code)
    unless country.nil?
      range = CarriersRange.find_by('zone_id = ?
                                AND ? >= greater_equal_than
                                AND ? < lower_than', country.zone, weight, weight)
    end

    cost = 0
    cost = range.amount unless range.nil?
    is_valid = !range.nil? || free_carrier

    [cost, is_valid]
  end
end
