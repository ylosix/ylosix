# == Schema Information
#
# Table name: tags_group_translations
#
#  created_at    :datetime         not null
#  id            :integer          not null, primary key
#  locale        :string           not null
#  name          :string
#  tags_group_id :integer          not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_tags_group_translations_on_locale         (locale)
#  index_tags_group_translations_on_tags_group_id  (tags_group_id)
#

class TagsGroupTranslation < ActiveRecord::Base
  belongs_to :tags_group
  belongs_to :language, primary_key: :locale, foreign_key: :locale
  # validates_uniqueness_of locale: { scope: :category_id }
end
