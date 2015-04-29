require 'test_helper'

class Admin::ProductsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    login_admin
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get edit' do
    product = products(:camera)

    get :edit, :id => product.id
    assert_response :success
  end

end