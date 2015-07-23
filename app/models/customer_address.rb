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

class CustomerAddress < ActiveRecord::Base
  belongs_to :customer, touch: true
  before_save :set_only_one_address_active

  store_accessor :fields, :customer_name
  store_accessor :fields, :customer_last_name, :business, :address_1,
                 :address_2, :postal_code, :city, :country, :phone,
                 :mobile_phone, :dni, :other

  # validates_length_of :name, :maximum => 10

  # be careful Costumer.has_many CustomerAddresses has a problem with hstore and cache.
  # scope :from_user, ->(customer) {
  #   where(customer_id: customer.id)
  # }

  def set_only_one_address_active
    CustomerAddress.where(customer_id: customer_id)
        .update_all(default_billing: false) if default_billing
    CustomerAddress.where(customer_id: customer_id)
        .update_all(default_shipping: false) if default_shipping
  end

  def to_liquid
    {
        'name' => name,
        'default_billing' => default_billing,
        'default_shipping' => default_shipping,
        'fields' => fields
    }
  end
end
