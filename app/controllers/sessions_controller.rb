class SessionsController < ApplicationController
  skip_before_action :authorize

  def new; end

  def create
    user = if User.count.zero?
             User.create(
               name: params[:name],
               password: params[:password],
               password_confirmation: params[:password_confirmation]
             )
           else
             User.find_by(name: params[:name])
           end

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, alert: 'Invalid user/password combination'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_index_url, notice: 'Logged out'
  end
end
