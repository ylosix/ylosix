require 'test_helper'

module Admin
  class CategoriesControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    def setup
      login_admin
      @object = categories(:digital_cameras)
    end

    test 'should index' do
      get :index
      assert_response :success
      assert_not_nil assigns(:categories)
    end

    test 'should index parent desc' do
      get :index, order: 'parent_desc'
      assert_response :success
      assert_not_nil assigns(:categories)
    end

    test 'should index parent asc' do
      get :index, order: 'parent_asc'
      assert_response :success
      assert_not_nil assigns(:categories)
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

    test 'should create' do
      assert_difference('Category.count') do
        post :create, category: @object.attributes
      end

      assert_redirected_to admin_category_path(assigns(:category))
    end

    test 'should update' do
      patch :update, id: @object, category: @object.attributes
      assert_redirected_to admin_category_path(assigns(:category))
    end
  end
end
