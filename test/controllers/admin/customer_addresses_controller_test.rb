require 'test_helper'

module Admin
  class CustomerAddressesControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    def setup
      login_admin
    end

    test 'should get index/edit/show' do
      get :index
      assert_response :success

      object = customer_addresses(:ca_example)
      get :edit, id: object.id
      assert_response :success

      get :show, id: object.id
      assert_response :success
    end
  end
end
