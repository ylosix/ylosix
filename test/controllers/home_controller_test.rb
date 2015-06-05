require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def prepare_template
    object = templates(:test_template)

    FileUtils.mkdir_p 'tmp/templates/test'
    File.open(File.join(Rails.root, 'tmp/templates/test/home_index.html'), 'w') do |f|
      f.write '<h1>hello world!</h1>'
    end

    params = { 'home_index' => '<h2>hello world!</h2>' }

    object.writes_files params
    object.enabled = true
    object.save

    object
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get index with template' do
    prepare_template

    get :index
    assert_response :success
  end

  test 'should get index with debug variables/template/locale' do
    prepare_template

    login_admin

    get :index
    assert_response :success
  end
end
