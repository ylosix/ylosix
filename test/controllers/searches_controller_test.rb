require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index, query_text: 'camera'
    assert_response :success

    assert assigns(:variables)

    variables = assigns(:variables)
    assert variables['products'].any?
  end
end
