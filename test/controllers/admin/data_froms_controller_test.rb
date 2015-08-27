require 'test_helper'

module Admin
  class DataFormsControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    def setup
      login_admin
      @object = data_forms(:one)
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
            data_form: {
                tag: 'Tag1',
                fields: "{\"hi\" => \"hello\"}"
            }
      assert_redirected_to admin_data_form_path(assigns(:data_form))
    end
  end
end
