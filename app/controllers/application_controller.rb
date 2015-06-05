class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

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
    session[:return_to] ||= request.referer

    return_url = session.delete(:return_to)
    return_url ||= root_url

    redirect_to return_url
  end

  # Overwrite unverified request handler to force a refresh / redirect.
  def handle_unverified_request
    super # call the default behaviour, including Devise override
    throw :warden, redirect: request.referer || request.url
  end

  private

  def set_locale
    if session[:locale].blank?
      session[:locale] = extract_locale_from_accept_language_header

      session[:locale] = current_admin_user.locale unless current_admin_user.nil?
      session[:locale] = current_customer.locale unless current_customer.nil?
    end

    if !current_admin_user.nil? && Language.locale_valid?(current_admin_user.debug_locale)
      session[:locale] = current_admin_user.debug_locale
    end

    I18n.locale = session[:locale]
  end

  def extract_locale_from_accept_language_header
    locale = I18n.default_locale

    if !request.nil? && !request.env['HTTP_ACCEPT_LANGUAGE'].nil?
      browser = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
      browser = browser.underscore
      locale = browser if Language.locale_valid?(browser)
    end

    locale
  end

  def permit_locale
    params.permit(:locale)
  end
end
