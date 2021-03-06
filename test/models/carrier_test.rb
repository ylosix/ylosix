# == Schema Information
#
# Table name: carriers
#
#  created_at         :datetime         not null
#  delay_translations :hstore           default({}), not null
#  enabled            :boolean          default(FALSE), not null
#  free_carrier       :boolean          default(FALSE), not null
#  id                 :integer          not null, primary key
#  image_content_type :string
#  image_file_name    :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  name_translations  :hstore           default({}), not null
#  priority           :integer          default(1), not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_carriers_on_enabled  (enabled)
#

require 'test_helper'

class CarrierTest < ActiveSupport::TestCase
  test 'calculate_shipping_cost_to' do
    carrier = carriers(:one)
    country = countries(:one)

    _, valid = carrier.calculate_shipping_cost_to(country.code, 0)
    assert valid
  end
end
