# == Schema Information
#
# Table name: category_translations
#
#  id          :integer          not null, primary key
#  category_id :integer          not null
#  locale      :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string
#
# Indexes
#
#  index_category_translations_on_category_id  (category_id)
#  index_category_translations_on_locale       (locale)
#

class CategoryTranslation < ActiveRecord::Base
  belongs_to :category
  belongs_to :language, primary_key: :locale, foreign_key: :locale
  # validates_uniqueness_of locale: { scope: :category_id }
end
