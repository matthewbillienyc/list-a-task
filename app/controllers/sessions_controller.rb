class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to user
    else
      flash[:danger]= 'Invalid email/password'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
