require 'test_helper'

class AddressesControllerTest < ActionController::TestCase
  # test 'should get index' do
  #   get :index
  #   assert_response :success
  # end

  test 'should get new without user' do
    get :new
    assert_response :redirect
  end

  test 'should get new user' do
    login_customer

    get :new
    assert_response :success
  end
end
