require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  def setup
    @customer = login_customer
  end

  test 'should get show with login user' do
    get :show
    assert_response :success
  end

  test 'should get orders with login user' do
    get :orders
    assert_response :success
  end

  test 'should invoice' do
    sop = shopping_orders(:two)

    get :invoice, id: sop
    assert_response :success
  end
end
