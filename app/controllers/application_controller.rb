class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :set_i18n_locale_from_params

  protected

  def set_i18n_locale_from_params
    return I18n.locale = I18n.default_locale unless params[:locale]

    if valid_locale?
      I18n.locale = params[:locale]
    else
      I18n.locale = I18n.default_locale
      flash.now[:notice] = "#{params[:locale]} translation not available"
      logger.error flash.now[:notice]
    end
  end

  private

  def valid_locale?
    I18n.available_locales.map(&:to_s).include?(params[:locale])
  end

  def authorize
    return if User.find_by(id: session[:user_id])

    redirect_to login_url, notice: 'Please log in'
  end
end
