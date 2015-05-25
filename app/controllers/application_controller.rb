class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_customer_locale

  def change_locale
    locale = I18n.default_locale.to_s
    param_locales = permit_locale

    unless param_locales[:locale].blank?
      locale_param = param_locales[:locale].parameterize.underscore.to_sym

      if I18n.available_locales.include?(locale_param)
        locale = param_locales[:locale]
      end
    end

    session[:locale] = locale
    redirect_to root_path
  end

  private

  def permit_locale
    params.permit(:locale)
  end

  def set_customer_locale
    session[:locale] = I18n.default_locale if session[:locale].blank?
    I18n.locale = session[:locale]
  end
end
