# == Schema Information
#
# Table name: features
#
#  created_at        :datetime         not null
#  id                :integer          not null, primary key
#  name_translations :hstore           default({}), not null
#  priority          :integer          default(1), not null
#  updated_at        :datetime         not null
#

class Feature < ActiveRecord::Base
  translates :name

  has_many :feature_translations

  accepts_nested_attributes_for :feature_translations

  ransacker :by_name, formatter: lambda { |search|
                      ids = Feature.where('lower(name_translations->?) LIKE lower(?)', I18n.locale, "%#{search}%").pluck(:id)
                      ids.any? ? ids : nil
                    } do |parent|
    parent.table[:id]
  end
end
