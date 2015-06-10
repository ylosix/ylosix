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

class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates :last_name, presence: true
  validates :birth_date, presence: true
  validates :locale, presence: true

  has_one :shopping_cart
  has_many :shopping_orders
  has_many :customer_addresses

  def intern_path
    helper = Rails.application.routes.url_helpers
    helper.show_customers_path
  end

  def shipping_address
    retrieve_address(default_shipping: true)
  end

  def billing_address
    retrieve_address(default_billing: true)
  end

  def to_liquid
    {
        'email' => email,
        'name' => name,
        'last_name' => last_name,
        'birth_date' => birth_date,
        'href' => Rails.application.routes.url_helpers.show_customers_path
    }
  end

  private

  def retrieve_address(options)
    address = CustomerAddress.find_by(options)
    address ||= CustomerAddress.first
    address
  end
end
