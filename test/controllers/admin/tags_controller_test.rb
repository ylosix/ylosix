require 'test_helper'

module Admin
  class TagsControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    def setup
      login_admin
    end

    test 'should get index' do
      get :index
      assert_response :success
    end

    test 'should get edit' do
      object = tags(:cameras)

      get :edit, id: object.id
      assert_response :success
    end
  end
end
