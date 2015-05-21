class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_user_locale

  def change_locale
    locale = I18n.default_locale
    if !params[:locale].blank? && I18n.available_locales.include?(:"#{params[:locale]}")
      locale = params[:locale]
    end

    session[:locale] = locale
    redirect_to root_path
  end

  private

  def set_user_locale
    session[:locale] = I18n.default_locale if session[:locale].blank?
    I18n.locale = session[:locale]
  end
end
