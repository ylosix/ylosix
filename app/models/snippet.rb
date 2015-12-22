# == Schema Information
#
# Table name: snippets
#
#  content_translations :hstore           default({}), not null
#  created_at           :datetime         not null
#  id                   :integer          not null, primary key
#  tag                  :string
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_snippets_on_tag  (tag)
#

class Snippet < ActiveRecord::Base
  translates :content

  has_many :snippet_translations
  accepts_nested_attributes_for :snippet_translations
end
