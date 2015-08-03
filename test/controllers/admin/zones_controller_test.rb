require 'test_helper'

module Admin
  class ZonesControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    def setup
      login_admin
    end

    test 'should get index/edit/show' do
      get :index
      assert_response :success

      object = zones(:one)
      get :edit, id: object.id
      assert_response :success

      get :show, id: object.id
      assert_response :success
    end
  end
end
