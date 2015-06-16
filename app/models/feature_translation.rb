# == Schema Information
#
# Table name: feature_translations
#
#  created_at :datetime         not null
#  feature_id :integer          not null
#  id         :integer          not null, primary key
#  locale     :string           not null
#  name       :string
#  updated_at :datetime         not null
#
# Indexes
#
#  index_feature_translations_on_feature_id  (feature_id)
#  index_feature_translations_on_locale      (locale)
#

class FeatureTranslation < ActiveRecord::Base
  belongs_to :feature
  belongs_to :language, primary_key: :locale, foreign_key: :locale
  # validates_uniqueness_of locale: { scope: :category_id }
end
