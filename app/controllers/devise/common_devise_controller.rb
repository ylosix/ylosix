class Devise::CommonDeviseController < Devise::RegistrationsController
  before_action :set_common_variables

  private

  def set_common_variables
    @variables = CommonFrontendController.static_set_common_variables
  end
end