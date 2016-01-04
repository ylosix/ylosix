# == Schema Information
#
# Table name: shopping_orders_statuses
#
#  color             :string
#  created_at        :datetime         not null
#  enable_invoice    :boolean
#  id                :integer          not null, primary key
#  name_translations :hstore           default({}), not null
#  updated_at        :datetime         not null
#

class ShoppingOrdersStatus < ActiveRecord::Base
  translates :name

  has_many :shopping_orders

  ransacker :by_name, formatter: lambda { |search|
                      ids = ShoppingOrdersStatus.where('lower(name_translations->?) LIKE lower(?)', I18n.locale, "%#{search}%").pluck(:id)
                      ids.any? ? ids : nil
                    } do |parent|
    parent.table[:id]
  end

  def to_liquid(_options = {})
    {
        'name' => name,
        'color' => color
    }
  end
end
