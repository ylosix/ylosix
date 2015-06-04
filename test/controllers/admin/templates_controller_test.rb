require 'test_helper'

module Admin
  class TemplatesControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    def setup
      login_admin
      FileUtils.mkdir_p 'tmp/templates/test/snippets'
      File.open('tmp/templates/test/home_index.html', 'w') do |f|
        f.write '<h1>hello world</h1>'
      end

      File.open('tmp/templates/test/snippets/header.html', 'w') do |f|
        f.write '<h1>hello world</h1>'
      end

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
      assert_response :redirect
    end

    test 'should export' do
      object = templates(:test_template)

      get :export, id: object.id
      assert_response :success
      assert_equal 'application/zip', response.content_type
    end

    test 'should get import' do
      object = templates(:test_template)
      get :import, id: object.id
      assert_response :success
    end

    test 'should post import' do
      object = templates(:test_template)
      zip_file = Utils.zip_folder(object.absolute_path)

      post :import, template: {file: zip_file}
    end
  end
end
