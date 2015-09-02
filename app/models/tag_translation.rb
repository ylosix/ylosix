# == Schema Information
#
# Table name: tag_translations
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  locale     :string           not null
#  name       :string
#  slug       :string
#  tag_id     :integer          not null
#  updated_at :datetime         not null
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
