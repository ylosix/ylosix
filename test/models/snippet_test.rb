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

require 'test_helper'

class SnippetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
