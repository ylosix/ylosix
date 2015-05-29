require 'test_helper'

module Admin
  class CategoriesControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    def setup
      login_admin
    end

    test 'should get index' do
      get :index
      assert_response :success
    end

    test 'should get edit' do
      object = categories(:digital_cameras)

      get :edit, id: object.id
      assert_response :success
    end
  end
end
