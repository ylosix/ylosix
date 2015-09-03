require 'test_helper'

module Admin
  class DesignFormsControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    def setup
      login_admin
      @object = design_forms(:one)
    end

    test 'should get index' do
      get :index
      assert_response :success
    end

    test 'should get show' do
      get :show, id: @object
      assert_response :success
    end

    test 'should get edit' do
      get :edit, id: @object
      assert_response :success
    end

    test 'should update' do
      patch :update,
            id: @object.id,
            design_form: {
                tag: 'Tag1'
            }
      assert_redirected_to admin_design_form_path(assigns(:design_form))
    end
  end
end
