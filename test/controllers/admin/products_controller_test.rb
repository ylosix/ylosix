require 'test_helper'

class Admin::ProductsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'should get index' do
    login_admin

    get :index
    assert_response :success
  end

  test 'should get edit' do
    login_admin

    product = Product.first

    get :edit, :id => product.id
    assert_response :success
  end

end