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
# Indexes
#
#  index_customer_addresses_on_customer_id  (customer_id)
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
                 :mobile_phone, :nif, :other

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

  def to_liquid(_options = {})
    hash = {
        'name' => name,
        'default_billing' => default_billing,
        'default_shipping' => default_shipping,
        'fields' => fields
    }

    unless id.blank?
      hash['edit_customers_address_path'] = Routes.edit_customers_address_path(self)
      hash['destroy_customers_address_path'] = Routes.customers_address_path(self)
      hash['update_customers_address_path'] = Routes.customers_address_path(self)
      hash['save_address_customers_shopping_orders_path'] = Routes.save_address_customers_shopping_orders_path(self)
    end

    hash
  end
end
