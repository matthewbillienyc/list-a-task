class UsersController < ApplicationController
  before_action :verify_user, only: [:show, :update]
  before_action :verify_logged_out, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "Welcome to the App!"
      redirect_to @user
    else
      flash[:danger] = "Oops! Try one more time."
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @list = List.new
    @task = Task.new
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:success] = "Avatar Saved!"
      redirect_to user_path(@user)
    else
      flash[:danger] = "Invalid File"
      redirect_to user_path(@user)
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :avatar)
    end
end
