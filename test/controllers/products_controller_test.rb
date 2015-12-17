require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @product = products(:camera)
    @product.save
  end

  test 'should get show' do
    get :show, product_id: @product.id
    assert_response :success

    get :show, product_id: @product.slug
    assert_response :success
  end

  test 'should add to shopping cart' do
    login_customer

    get :add_to_shopping_cart, product_id: @product.id
    assert_response :redirect

    get :delete_from_shopping_cart, product_id: @product.id
    assert_response :redirect

    get :add_to_shopping_cart, product_id: @product.id
    assert_response :redirect

    object = products(:lens_canon)
    get :add_to_shopping_cart, product_id: object.id
    assert_response :redirect
  end

  test 'should add to shopping cart session' do
    get :add_to_shopping_cart, product_id: @product.id
    assert_response :redirect
  end
end
