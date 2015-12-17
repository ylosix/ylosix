require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = categories(:digital_cameras)
    @category.save
  end

  test 'should get index' do
    get :index, format: 'json'
    assert_response :success
  end

  test 'should get show' do
    get :show, category_id: @category.slug
    assert_response :success

    get :show, category_id: @category.id
    assert_response :success

    # TODO: check when id nil return 404 not found
  end

  test 'should get tag' do
    tag = tags(:cameras)

    get :tags, category_id: @category.id, slug_tags: tag.id
    assert_response :success
  end

  test 'shold get notfound' do
    get :show, category_id: 'not-found'
    assert_response :not_found
  end
end
