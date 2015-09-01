# == Schema Information
#
# Table name: action_form_translations
#
#  action_form_id :integer          not null
#  body           :text
#  created_at     :datetime         not null
#  id             :integer          not null, primary key
#  locale         :string           not null
#  subject        :string
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_action_form_translations_on_action_form_id  (action_form_id)
#  index_action_form_translations_on_locale          (locale)
#

class ActionFormTranslation < ActiveRecord::Base
  belongs_to :action_form
  belongs_to :language, primary_key: :locale, foreign_key: :locale
  # validates_uniqueness_of locale: { scope: :category_id }
end
