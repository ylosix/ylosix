require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  test 'should change_locale' do
    get :change_locale, locale: :en
    assert_response :redirect
  end
end
