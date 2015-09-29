# == Schema Information
#
# Table name: snippet_translations
#
#  content    :text
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  locale     :string           not null
#  snippet_id :integer          not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_snippet_translations_on_locale      (locale)
#  index_snippet_translations_on_snippet_id  (snippet_id)
#

class SnippetTranslation < ActiveRecord::Base
  belongs_to :snippet
  belongs_to :language, primary_key: :locale, foreign_key: :locale
end
