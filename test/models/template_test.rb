# == Schema Information
#
# Table name: templates
#
#  id         :integer          not null, primary key
#  name       :string
#  path       :string
#  enabled    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TemplateTest < ActiveSupport::TestCase
  test 'public path' do
    template = templates(:test_template)
    assert !template.public_path.blank?
  end

  test 'to_liquid' do
    hash = templates(:test_template).to_liquid

    assert hash.key? 'name'
    assert hash.key? 'path'
    assert hash.key? 'public_path'
    assert hash.key? 'enabled'
  end
end
