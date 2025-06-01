class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(name: params[:name])

    if user&.authenticate(params[:password])
      # use the Ruby Safe Navigation Operator, which checks if a variable has a value of nil beore
      # trying to call the method
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
