module Customers
  class SessionsController < Devise::SessionsController
    include Frontend::CommonModule

    before_filter :set_breadcrumb
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

    protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.for(:sign_in) << :attribute
    # end

    def set_breadcrumb
      add_breadcrumb(Breadcrumb.new(url: show_customers_path, name: 'Customers'))
    end
  end
end
