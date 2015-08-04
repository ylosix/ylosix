# == Schema Information
#
# Table name: admin_users
#
#  created_at             :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  debug_template_id      :integer
#  debug_variables        :boolean          default(FALSE), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  id                     :integer          not null, primary key
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locale                 :string           default("en"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  updated_at             :datetime
#
# Indexes
#
#  index_admin_users_on_email                 (email) UNIQUE
#  index_admin_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'test_helper'

class AdminUserTest < ActiveSupport::TestCase
  test 'intern_path' do
    object = admin_users(:admin_user)
    assert !object.intern_path.blank?
  end
end
