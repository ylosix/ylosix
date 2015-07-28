# == Schema Information
#
# Table name: product_translations
#
#  created_at        :datetime         not null
#  description       :text
#  features          :hstore
#  id                :integer          not null, primary key
#  locale            :string           not null
#  name              :string
#  product_id        :integer          not null
#  short_description :text
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
  after_initialize :reload_hstore

  private

  def reload_hstore
    Feature.all.each do |feature|
      ProductTranslation.store_accessor :features, feature.id.to_s.to_sym
    end
  end

  # validates_uniqueness_of locale: { scope: :category_id }
end
