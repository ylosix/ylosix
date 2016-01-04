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

class CustomersControllerTest < ActionController::TestCase
  def setup
    @customer = login_customer
  end

  test 'should get show with login user' do
    get :show
    assert_response :success
  end

  test 'should get orders with login user' do
    get :orders
    assert_response :success
  end

  test 'should invoice' do
    sop = shopping_orders(:two)

    get :invoice, id: sop
    assert_response :success
  end
end
