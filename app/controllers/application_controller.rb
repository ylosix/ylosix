class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  # if !Rails.env.production? # TODO In the future this only is for development
  before_action :get_debug_params
  # end

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

  private

  def get_debug_params
    @variables ||= {}

    params_debug = permit_debug_params
    unless params_debug[:debug_variables].blank?
      @variables['debug_variables'] = params_debug[:debug_variables].to_i
    end

    unless params_debug[:debug_template_id].blank?
      @variables['debug_template_id'] = params_debug[:debug_template_id].to_i
    end
  end

  def set_locale
    if session[:locale].blank?
      session[:locale] = extract_locale_from_accept_language_header
      session[:locale] = I18n.default_locale unless Language.locale_valid?(session[:locale])
    end

    session[:locale] = current_customer.locale unless current_customer.nil?
    if Language.locale_valid?(params[:locale])
      session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale]
  end

  def extract_locale_from_accept_language_header
    locale = nil

    if !request.nil? && !request.env['HTTP_ACCEPT_LANGUAGE'].nil?
      locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end

    locale
  end

  def permit_locale
    params.permit(:locale)
  end

  def permit_debug_params
    params.permit(:debug_variables, :debug_template_id)
  end
end
