# == Schema Information
#
# Table name: customer_addresses
#
#  created_at       :datetime         not null
#  customer_id      :integer
#  default_billing  :boolean          default(FALSE), not null
#  default_shipping :boolean          default(FALSE), not null
#  fields           :hstore           default({}), not null
#  id               :integer          not null, primary key
#  name             :string
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_79041ef784  (customer_id => customers.id)
#

require 'test_helper'

class CustomerAddressTest < ActiveSupport::TestCase
  test 'retrieve shipping/billing address' do
    customer = customers(:customer_example)
    assert !customer.shipping_address.nil?
    assert !customer.billing_address.nil?
  end

  test 'to_liquid' do
    hash = customer_addresses(:ca_example).to_liquid

    assert hash.key? 'name'
    assert hash.key? 'default_billing'
    assert hash.key? 'default_shipping'
    assert hash.key? 'fields'
  end

  test 'set_only_one_address_active' do
    customer = customers(:customer_example)
    ca = CustomerAddress.new(customer: customer)

    ca.default_shipping = true
    ca.default_billing = true
    ca.save

    cas = CustomerAddress.where(customer_id: customer.id, default_billing: true)
    assert cas.size == 1
    assert cas.first.id = ca.id

    cas = CustomerAddress.where(customer_id: customer.id, default_shipping: true)
    assert cas.size == 1
    assert cas.first.id = ca.id
  end
end
