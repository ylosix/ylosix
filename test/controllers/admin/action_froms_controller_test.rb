require 'test_helper'

module Admin
  class ActionFormsControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    def setup
      login_admin
      @object = action_forms(:one)
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
            action_form: {
                tag: 'Tag1',
                mapping: "{\"hi\" => \"hello\"}"
            }
      assert_redirected_to admin_action_form_path(assigns(:action_form))
    end
  end
end
