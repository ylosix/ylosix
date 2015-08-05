require 'test_helper'

module Admin
  class ProductsControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    def setup
      login_admin
      @object = products(:camera)
    end

    test 'should index' do
      get :index
      assert_response :success
      assert_not_nil assigns(:products)
    end

    test 'should clone' do
      get :new, id: @object.id
      assert_response :success
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
      assert_difference('Product.count') do
        post :create, product: @object.attributes
      end

      assert_redirected_to admin_product_path(assigns(:product))
    end

    test 'should update' do
      attributes = @object.attributes
      attributes[:products_categories_ids] = [categories(:digital_cameras).id]
      attributes[:products_tags_ids] = [tags(:cameras).id]

      patch :update, id: @object, product: attributes
      assert_redirected_to admin_product_path(assigns(:product))
    end
  end
end
