require 'test_helper'

class Admin::AdminUsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    login_admin
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get edit' do
    user = AdminUser.first

    get :edit, id: user.id
    assert_response :success
  end
end
