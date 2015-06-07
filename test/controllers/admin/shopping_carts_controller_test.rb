require 'test_helper'

module Admin
  class ShoppingCartsControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    def setup
      login_admin
    end

    test 'should get index/edit/show' do
      get :index
      assert_response :success

      object = shopping_carts(:customer_example_sc)

      get :show, id: object.id
      assert_response :success

      get :edit, id: object.id
      assert_response :success
    end
  end
end
