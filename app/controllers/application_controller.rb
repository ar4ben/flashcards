class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :require_login

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def set_locale
    locale = params[:locale]
    I18n.locale = if locale && I18n.available_locales.include?(locale.to_sym)
                    locale.to_sym
                  else
                    http_accept_language.compatible_language_from(I18n.available_locales)
                  end
  end

  def not_authenticated
    redirect_to login_path, alert: "Пожалуйста, залогинтесь"
  end
end
