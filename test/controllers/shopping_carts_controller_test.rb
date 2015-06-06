require 'test_helper'

class ShoppingCartsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'should get show' do
    get :show
    assert_response :success
  end

  test 'should get show with login user' do
    login_customer

    get :show
    assert_response :success
  end

  test 'should get update with login user' do
    login_customer
    scp = shopping_carts_products(:scp_camera)

    get :update, product_id: scp.product.id, quantity: 5
    assert_response :redirect
  end
end
