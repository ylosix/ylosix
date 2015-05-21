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

class CategoryTranslation < ActiveRecord::Base
  belongs_to :category
  belongs_to :language, primary_key: 'code', foreign_key: 'locale'
  # validates_uniqueness_of locale: { scope: :category_id }
end
