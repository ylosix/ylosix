require 'test_helper'

module Admin
  class ShoppingOrdersControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    def setup
      login_admin
    end

    test 'should get index/show/edit' do
      get :index
      assert_response :success

      object = shopping_orders(:customer_example_so)

      get :edit, id: object.id
      assert_response :success

      get :show, id: object.id
      assert_response :success
    end

    test 'should get invoice' do
      object = shopping_orders(:customer_example_so)

      get :invoice, id: object.id
      assert_response :success
    end
  end
end
