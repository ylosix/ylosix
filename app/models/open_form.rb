# == Schema Information
#
# Table name: open_forms
#
#  created_at :datetime         not null
#  fields     :hstore           default({}), not null
#  id         :integer          not null, primary key
#  tag        :string
#  updated_at :datetime         not null
#

class OpenForm < ActiveRecord::Base
end
