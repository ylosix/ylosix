require 'test_helper'

class Admin::TemplatesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    login_admin
    FileUtils.mkdir_p 'tmp/templates/test'

    object = templates(:test_template)
    object.enabled = true
    object.save
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get edit' do
    object = templates(:test_template)

    get :edit, id: object.id
    assert_response :success
  end
end
