# == Schema Information
#
# Table name: design_forms
#
#  content_translations :hstore           default({}), not null
#  created_at           :datetime         not null
#  id                   :integer          not null, primary key
#  tag                  :string
#  updated_at           :datetime         not null
#

class DesignForm < ActiveRecord::Base
  translates :content
end
