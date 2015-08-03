# == Schema Information
#
# Table name: shopping_orders_statuses
#
#  color          :string
#  created_at     :datetime         not null
#  enable_invoice :boolean
#  id             :integer          not null, primary key
#  name           :string
#  updated_at     :datetime         not null
#

class ShoppingOrdersStatus < ActiveRecord::Base
  translates :name

  has_many :shopping_orders
  has_many :shopping_orders_status_translations
  accepts_nested_attributes_for :shopping_orders_status_translations
end
