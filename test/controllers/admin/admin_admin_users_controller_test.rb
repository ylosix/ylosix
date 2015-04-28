require 'test_helper'

class Admin::AdminUsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'should get index' do
    login_admin

    get :index
    assert_response :success
  end

  test 'should get edit' do
    user = login_admin

    get :edit, :id => user.id
    assert_response :success
  end

end