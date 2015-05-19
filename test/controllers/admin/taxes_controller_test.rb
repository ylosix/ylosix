require 'test_helper'

class Admin::TaxesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    login_admin
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get edit' do
    object = taxes(:iva_es)

    get :edit, id: object.id
    assert_response :success
  end
end
