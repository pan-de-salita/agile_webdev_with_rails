class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :set_i18n_locale_from_params

  protected

  def set_i18n_locale_from_params
    return unless params[:locale]

    if I18n.available_locales.map(&:to_s).include?(params[:locale])
      I18n.locale = params[:locale]
    else
      flash.now[:notice] = "#{params[:locale]} translation not available"
      logger.error flash.now[:notice]
    end
  end

  private

  def authorize
    return if User.find_by(id: session[:user_id])

    redirect_to login_url, notice: 'Please log in'
  end
end
