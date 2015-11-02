class ApplicationController < ActionController::Base
  class InvalidPathError < StandardError; end

  include ShowActionName
  include ActiveRecord

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :extract_commerce_from_url, :set_locale

  rescue_from ActiveRecord::RecordNotFound, with: :not_found_exception
  rescue_from InvalidPathError, with: :not_found_exception

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
    session[:return_to] ||= request.referer || request.url || root_url

    return_url = session.delete(:return_to)
    redirect_to return_url
  end

  # Overwrite unverified request handler to force a refresh / redirect.
  def handle_unverified_request
    # super # call the default behaviour, including Devise override
    flash[:alert] = 'Error with CSRF'
    throw :warden, redirect: request.referer || request.url
  end

  # After sign in set user locale.
  def after_sign_in_path_for(resource)
    if !resource.nil? && Language.locale_valid?(resource.locale)
      session[:locale] = resource.locale
    end

    # login admin and login customer.
    if !session[:shopping_cart].blank? && !current_customer.nil?
      # TODO if exist customer shopping cart append the products.
      ShoppingCart.retrieve(current_customer, session[:shopping_cart])
      session.delete :shopping_cart
    end

    resource.intern_path
  end

  private

  def set_locale
    if session[:locale].nil?
      language = @commerce.language
      language ||= Language.find_by(default: true)

      if language.nil?
        session[:locale] = extract_locale_from_accept_language_header
      else
        session[:locale] = language.locale
      end
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

  def extract_commerce_from_url
    @commerce = Commerce.retrieve(retrieve_http_server_name)
    @render_template = @commerce.template
    @render_template.from = 'commerce' unless @render_template.nil?

    enabled_template = Template.active_template(current_admin_user)
    @render_template = enabled_template unless enabled_template.nil?

    @variables ||= {}
    @variables['commerce'] = @commerce.to_liquid
    @variables['meta_tags'] = @commerce.meta_tags
    @variables['template'] = @render_template
  end

  def retrieve_http_server_name
    http = nil
    if !request.nil? && !request.env['SERVER_NAME'].nil?
      http = request.env['SERVER_NAME']
      http = http[4..-1] if http.starts_with?('www.')
    end

    http
  end

  def permit_locale
    params.permit(:locale)
  end

  def not_found_exception(exception = nil)
    logger.info "Rendering 404: #{exception.message}" if exception

    render 'errors/not_found', status: 404
  end
end
