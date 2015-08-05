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

      @object = templates(:test_template)
      @object.enabled = true
      @object.save
    end

    test 'should index' do
      get :index
      assert_response :success
      assert_not_nil assigns(:templates)
    end

    test 'should show' do
      get :show, id: @object
      assert_response :success
    end

    test 'should edit' do
      get :edit, id: @object
      assert_response :success
    end

    test 'should create' do
      assert_difference('Template.count') do
        post :create, template: @object.attributes
      end

      assert_redirected_to admin_template_path(assigns(:template))
    end

    test 'should update' do
      patch :update,
            id: @object.id,
            template: {
                name: 'Some title',
                path: 'tmp/templates/test',
                enabled: true
            }
      assert_redirected_to admin_template_path(assigns(:template))
    end

    test 'should destroy' do
      assert_difference('Template.count', -1) do
        delete :destroy, id: @object.id
      end

      assert_redirected_to admin_templates_path
    end

    test 'should export' do
      get :export, id: @object.id
      assert_response :success

      assert_equal 'application/zip', response.content_type
    end

    test 'should get import' do
      get :import, id: @object.id
      assert_response :success
    end

    test 'should post import' do
      zip_file = Utils.zip_folder(@object.absolute_path)
      file = Rack::Test::UploadedFile.new(zip_file, 'application/zip')

      post :import, template: {file: file}
      assert_response :redirect
    end
  end
end
