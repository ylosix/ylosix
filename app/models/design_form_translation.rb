# == Schema Information
#
# Table name: design_form_translations
#
#  content        :text
#  created_at     :datetime         not null
#  design_form_id :integer          not null
#  id             :integer          not null, primary key
#  locale         :string           not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_design_form_translations_on_design_form_id  (design_form_id)
#  index_design_form_translations_on_locale          (locale)
#

class DesignFormTranslation < ActiveRecord::Base
  belongs_to :design_form
  belongs_to :language, primary_key: :locale, foreign_key: :locale
  # validates_uniqueness_of locale: { scope: :category_id }
end
