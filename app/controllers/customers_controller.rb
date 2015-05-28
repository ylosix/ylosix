class CustomersController < ApplicationController
  include CommonControllerModule

  before_action :authenticate_customer!
  before_action :set_customer

  def show
  end

  private

  def set_customer
    @customer = current_customer
  end
end
