# == Schema Information
#
# Table name: category_translations
#
#  category_id       :integer          not null
#  created_at        :datetime         not null
#  description       :text             default(""), not null
#  id                :integer          not null, primary key
#  locale            :string           not null
#  meta_tags         :hstore           default({}), not null
#  name              :string           default(""), not null
#  short_description :text             default(""), not null
#  slug              :string           default(""), not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_category_translations_on_category_id  (category_id)
#  index_category_translations_on_locale       (locale)
#  index_category_translations_on_slug         (slug)
#

class CategoryTranslation < ActiveRecord::Base
  belongs_to :category
  belongs_to :language, primary_key: :locale, foreign_key: :locale
  # validates_uniqueness_of locale: { scope: :category_id }
end
