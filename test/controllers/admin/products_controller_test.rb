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
    object = products(:camera)

    get :edit, id: object.id
    assert_response :success
  end

  test 'should get show' do
    object = products(:camera)

    get :show, id: object.id
    assert_response :success
  end

  test 'should get clone' do
    object = products(:camera)

    get :new, product_id: object.id
    assert_response :success
  end
end
