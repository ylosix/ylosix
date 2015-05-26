class CustomersController < ApplicationController
  include CommonControllerModule

  before_action :authenticate_customer!

  def show
  end
end
