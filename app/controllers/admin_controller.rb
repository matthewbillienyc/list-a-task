class AdminController < ApplicationController
  include AdminHelper
  protect_from_forgery except: [:change_admin_priveledges]
  before_action :verify_admin

  def home
    @users = User.all
  end

  def change_admin_priveledges
    user = User.find(params[:id])
    user.admin = true
    user.save
    flash[:success] = "#{user.username} now has admin access."
    redirect_to admin_path
  end
end
