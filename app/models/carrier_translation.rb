# == Schema Information
#
# Table name: carrier_translations
#
#  carrier_id :integer          not null
#  created_at :datetime         not null
#  delay      :string
#  id         :integer          not null, primary key
#  locale     :string           not null
#  name       :string
#  updated_at :datetime         not null
#
# Indexes
#
#  index_carrier_translations_on_carrier_id  (carrier_id)
#  index_carrier_translations_on_locale      (locale)
#

class CarrierTranslation < ActiveRecord::Base
  belongs_to :carrier
  belongs_to :language, primary_key: :locale, foreign_key: :locale
  # validates_uniqueness_of locale: { scope: :category_id }
end
