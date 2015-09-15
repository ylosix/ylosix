require 'test_helper'

module Admin
  class CommercesControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    setup do
      login_admin
    end

    test 'should get index/edit/show' do
      get :index
      assert_response :success

      object = commerces(:one)
      get :edit, id: object.id
      assert_response :success

      get :show, id: object.id
      assert_response :success
    end

    test 'should post update' do
      object = commerces(:one)
      object.social_networks = {twitter: 'aaaaa', facebook: 'peito.com'}
      patch :update, id: object.id, commerce: object.attributes
      assert_response :redirect
    end
  end
end
