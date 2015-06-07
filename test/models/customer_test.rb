# == Schema Information
#
# Table name: customers
#
#  birth_date             :date
#  created_at             :datetime         not null
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  enabled                :boolean
#  encrypted_password     :string           default(""), not null
#  id                     :integer          not null, primary key
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locale                 :string           default("en"), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_customers_on_email                 (email) UNIQUE
#  index_customers_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  test 'intern_path' do
    object = customers(:customer_example)
    assert !object.intern_path.blank?
  end

  test 'to_liquid' do
    hash = customers(:customer_example).to_liquid

    assert hash.key? 'email'
    assert hash.key? 'name'
    assert hash.key? 'last_name'
    assert hash.key? 'birth_date'
    assert hash.key? 'href'
  end
end
