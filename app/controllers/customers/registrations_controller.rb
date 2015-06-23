module Customers
  class RegistrationsController < Devise::RegistrationsController
    include Frontend::CommonModule

    before_filter :configure_sign_up_params, only: [:create]
    before_filter :configure_account_update_params, only: [:update]

    before_action :initialize_breadcrumb, :set_breadcrumbs

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    # def create
    #   super
    # end

    # GET /resource/edit
    def edit
      add_breadcrumb(Breadcrumb.new(url: edit_customer_registration_path, name: 'Edit'))
      super
    end

    # PUT /resource
    # def update
    #   super
    # end

    # DELETE /resource
    # def destroy
    #   super
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    protected

    def set_breadcrumbs
      add_breadcrumb(Breadcrumb.new(url: show_customers_path, name: 'Customers'))
    end

    def after_update_path_for(_resource)
      show_customers_path
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.for(:sign_up) << :name
      devise_parameter_sanitizer.for(:sign_up) << :last_name
      devise_parameter_sanitizer.for(:sign_up) << :birth_date
      devise_parameter_sanitizer.for(:sign_up) << :locale
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      devise_parameter_sanitizer.for(:account_update) << :name
      devise_parameter_sanitizer.for(:account_update) << :last_name
      devise_parameter_sanitizer.for(:account_update) << :birth_date
      devise_parameter_sanitizer.for(:account_update) << :locale
    end

    # The path used after sign up.
    # def after_sign_up_path_for(resource)
    #   super(resource)
    # end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end
  end
end
