# == Schema Information
#
# Table name: tag_translations
#
#  id         :integer          not null, primary key
#  tag_id     :integer          not null
#  locale     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#
# Indexes
#
#  index_tag_translations_on_locale  (locale)
#  index_tag_translations_on_tag_id  (tag_id)
#

class TagTranslation < ActiveRecord::Base
  belongs_to :tag
  belongs_to :language, primary_key: :locale, foreign_key: :locale
  # validates_uniqueness_of locale: { scope: :category_id }
end
