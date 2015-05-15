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

  test 'should post update' do
    object = templates(:test_template)

    patch :update,
          id: object.id,
          template: {
              name: 'Some title',
              path: 'tmp/templates/test',
              enabled: true
          }
    assert_response 302
  end
end
