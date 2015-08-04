require 'test_helper'

module Admin
  class AdminUsersControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    def setup
      login_admin
      @object = admin_users(:admin_user)
    end

    test 'should index' do
      get :index
      assert_response :success
      assert_not_nil assigns(:admin_users)
    end

    test 'should new' do
      get :new
      assert_response :success
    end

    test 'should show' do
      get :show, id: @object
      assert_response :success
    end

    test 'should edit' do
      get :edit, id: @object
      assert_response :success
    end

    # test 'should create' do
    #   assert_difference('AdminUser.count') do
    #     post :create, admin_user: @object.attributes
    #   end
    #
    #   assert_redirected_to admin_category_path(assigns(:admin_user))
    # end

    test 'should update' do
      patch :update, id: @object, admin_user: @object.attributes
      assert_redirected_to admin_admin_user_path(assigns(:admin_user))
    end
  end
end
