class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale, :extract_commerce_from_url

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
    session[:locale] ||= extract_locale_from_accept_language_header

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

  def extract_commerce_from_url
    @variables ||= {}
    if !request.nil? && !request.env['SERVER_NAME'].nil?
      http = request.env['SERVER_NAME']
      http = http[4..-1] if http.starts_with?('www.')
      @variables['commerce'] ||= Commerce.find_by(http: http)
    end

    @variables['commerce'] ||= Commerce.find_by(default: true)
    @variables['commerce'] ||= Commerce.new

    @render_template = @variables['commerce'].template
    unless current_admin_user.nil?
      @render_template = Template.active_template(current_admin_user)
    end

    @variables['commerce'].root_href = root_path
  end

  def permit_locale
    params.permit(:locale)
  end
end
