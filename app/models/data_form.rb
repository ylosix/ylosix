# == Schema Information
#
# Table name: data_forms
#
#  created_at :datetime         not null
#  fields     :hstore           default({}), not null
#  id         :integer          not null, primary key
#  tag        :string
#  updated_at :datetime         not null
#

class DataForm < ActiveRecord::Base
  has_many :action_forms, foreign_key: 'tag', primary_key: 'tag'
end
