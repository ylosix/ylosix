# == Schema Information
#
# Table name: articles
#
#  created_at  :datetime         not null
#  description :string
#  id          :integer          not null, primary key
#  name        :string
#  updated_at  :datetime         not null
#

class Article < ActiveRecord::Base

  	def to_param
    	"#{id} #{name}".parameterize
  	end

end
