require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test 'should get show' do
    object = products(:camera)
    get :show, id: object.id
    assert_response :success

    object = products(:camera)
    get :show, slug: object.slug
    assert_response :success
  end
end
