require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get index with template' do
    object = templates(:test_template)

    FileUtils.mkdir_p 'tmp/templates/test'
    File.open(File.join(Rails.root, 'tmp/templates/test/home_index.html'), 'w') do |f|
      f.write '<h1>hello world!</h1>'
    end

    params = { 'home_index' => '<h2>hello world!</h2>' }

    object.writes_files params
    object.enabled = true
    object.save

    get :index
    assert_response :success
  end
end
