require 'test_helper'

module Admin
  class CarriersControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    def setup
      login_admin
      @object = carriers(:one)
    end

    test 'should index' do
      get :index
      assert_response :success
      assert_not_nil assigns(:carriers)
    end

    test 'should new' do
      get :new
      assert_response :success
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
      assert_difference('Carrier.count') do
        post :create, carrier: @object.attributes
      end

      assert_redirected_to admin_carrier_path(assigns(:carrier))
    end

    test 'should update' do
      @zone = zones(:one)
      patch :update, id: @object, carrier: @object.attributes,
            carriers_ranges: [{'999' =>
                                   {'greater_equal_than' => '1',
                                    'lower_than' => '2',
                                    'zones' => [{'amount' => '3', 'zone_id' => @zone.id}]},
                               '1000' =>
                                   {'greater_equal_than' => '3',
                                    'lower_than' => '4',
                                    'zones' => [{'amount' => '5', 'zone_id' => @zone.id}]}}]
      assert_redirected_to admin_carrier_path(assigns(:carrier))
    end
  end
end
