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

  accepts_nested_attributes_for :feature_translations
end
