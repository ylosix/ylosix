require 'test_helper'

class ShoppingOrdersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'should get show with login user' do
    login_customer

    get :show
    assert_response :success
  end

  test 'should get finalize with login user' do
    login_customer

    get :finalize
    assert_response :redirect
  end
end
