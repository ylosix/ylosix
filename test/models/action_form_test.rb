# == Schema Information
#
# Table name: action_forms
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  mapping    :hstore           default({}), not null
#  tag        :string
#  updated_at :datetime         not null
#

require 'test_helper'

class ActionFormTest < ActiveSupport::TestCase
  test 'perform_with_data' do
    action_form = action_forms(:one)
    data_form = data_forms(:one)

    action_form.perform_with_data(data_form)

    assert true
  end
end
