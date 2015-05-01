require 'test_helper'

class Admin::CategoriesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    login_admin
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get edit' do
    category = categories(:digital_cameras)

    get :edit, :id => category.id
    assert_response :success
  end

end