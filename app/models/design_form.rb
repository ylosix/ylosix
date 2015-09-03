# == Schema Information
#
# Table name: design_forms
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  tag        :string
#  updated_at :datetime         not null
#

class DesignForm < ActiveRecord::Base
  translates :content

  has_many :design_form_translations
  accepts_nested_attributes_for :design_form_translations
end
