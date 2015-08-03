# == Schema Information
#
# Table name: shopping_orders_status_translations
#
#  created_at                :datetime         not null
#  id                        :integer          not null, primary key
#  locale                    :string           not null
#  name                      :string
#  shopping_orders_status_id :integer          not null
#  updated_at                :datetime         not null
#
# Indexes
#
#  index_399201030a1e00009a10a366a42b0d8bdbb6ca7d       (shopping_orders_status_id)
#  index_shopping_orders_status_translations_on_locale  (locale)
#

class ShoppingOrdersStatusTranslation < ActiveRecord::Base
  belongs_to :shopping_orders_status
  belongs_to :language, primary_key: :locale, foreign_key: :locale
end
