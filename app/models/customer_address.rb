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

class CustomerAddress < ActiveRecord::Base
  belongs_to :customer, touch: true

  store_accessor :fields, :customer_name
  store_accessor :fields, :customer_last_name, :business, :address_1,
                 :address_2, :postal_code, :city, :country, :phone,
                 :mobile_phone, :dni, :other

  # validates_length_of :name, :maximum => 10

  # be careful Costumer.has_many CustomerAddresses has a problem with hstore and cache.
  # scope :from_user, ->(customer) {
  #   where(customer_id: customer.id)
  # }

  def to_liquid
    {
        'name' => name,
        'default_billing' => default_billing,
        'default_shipping' => default_shipping,
        'fields' => fields
    }
  end
end
