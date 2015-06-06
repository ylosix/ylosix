module Customers
  class SessionsController < Devise::SessionsController
    include Frontend::CommonModule

    # before_filter :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    # def create
    #   super
    # end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.for(:sign_in) << :attribute
    # end

    # After sign in set user locale.
    def after_sign_in_path_for(_resource)
      session[:locale] = current_customer.locale unless current_customer.nil?
      show_customers_path
    end
  end
end
