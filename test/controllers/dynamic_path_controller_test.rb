require 'test_helper'

class DynamicPathControllerTest < ActionController::TestCase
  test 'should route to first-level category' do
    assert_routing '/digital-cameras', controller: 'dynamic_path', action: 'show_path', path: 'digital-cameras'
  end

  test 'should route to deep category' do
    assert_routing '/digital-cameras/digital-cameras-child', controller: 'dynamic_path', action: 'show_path', path: 'digital-cameras/digital-cameras-child'
  end

  test 'should route to product under category' do
    assert_routing '/digital-cameras/camera', controller: 'dynamic_path', action: 'show_path', path: 'digital-cameras/camera'
  end

  test 'should route to product' do
    assert_routing '/camera', controller: 'dynamic_path', action: 'show_path', path: 'camera'
  end

  test 'should render product' do
    get :show_path, 'path' => 'camera-reflex-canon-450D'
    assert_template 'products/show'
  end

  test 'should render product when category is also present' do
    get :show_path, 'path' => 'digital-cameras/camera-reflex-canon-450D'
    assert_template 'products/show'
  end

  test 'should render category' do
    get :show_path, 'path' => 'digital-cameras'
    assert_template 'categories/show'
  end
end
