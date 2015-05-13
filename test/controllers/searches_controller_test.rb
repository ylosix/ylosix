require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index, :query_text => 'camera'
    assert_response :success
  end

end
