require 'test_helper'

module Admin
  class DataFormsControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    def setup
      login_admin
    end

    test 'should get index' do
      get :index
      assert_response :success
    end
  end
end
