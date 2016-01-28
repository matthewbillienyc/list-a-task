class SessionsController < ApplicationController
  before_action :verify_logged_out, only: [:new, :create]
  before_action :verify_logged_in, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      flash[:success] = "Welcome back!"
      redirect_to user
    else
      flash[:danger]= 'Invalid username/password'
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = "Goodbye!"
    redirect_to root_url
  end
end
