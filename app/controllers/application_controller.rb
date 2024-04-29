class ApplicationController < ActionController::Base
  around_action :switch_locale

  def switch_locale(&action)
    locale = set_locale
    I18n.with_locale(locale, &action)
  end

  def set_locale
    (configure_locale_case_valid) || I18n.default_locale
  end

  def configure_locale_case_valid
    if params[:locale].present?
      user_locale_param = params[:locale].to_sym

      (I18n.available_locales.include? user_locale_param) ? 
        user_locale_param
        : 
        nil
    end
  end

  # def default_url_options
  #   { locale: I18n.locale }
  # end
end
