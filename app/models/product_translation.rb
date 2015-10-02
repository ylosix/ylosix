# == Schema Information
#
# Table name: product_translations
#
#  created_at        :datetime         not null
#  description       :text
#  features          :hstore
#  id                :integer          not null, primary key
#  locale            :string           not null
#  meta_tags         :hstore           default({}), not null
#  name              :string
#  product_id        :integer          not null
#  short_description :text
#  slug              :string
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_product_translations_on_locale      (locale)
#  index_product_translations_on_product_id  (product_id)
#

class ProductTranslation < ActiveRecord::Base
  belongs_to :product
  belongs_to :language, primary_key: :locale, foreign_key: :locale

  # validates_uniqueness_of locale: { scope: :category_id }
end
