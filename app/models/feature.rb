# == Schema Information
#
# Table name: features
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string
#  priority   :integer          default(1), not null
#  updated_at :datetime         not null
#

class Feature < ActiveRecord::Base
  translates :name

  has_many :feature_translations
  after_save :reload_product_translations

  accepts_nested_attributes_for :feature_translations

  private

  def reload_product_translations
    ProductTranslation.reset_column_information
  end
end
