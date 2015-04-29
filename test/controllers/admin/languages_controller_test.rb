require 'test_helper'

class Admin::LanguagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    login_admin
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get edit' do
    language = languages(:es)

    get :edit, :id => language.id
    assert_response :success
  end

end