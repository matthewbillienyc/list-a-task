	class AdminController < ApplicationController
  include AdminHelper
  before_action :verify_admin
  before_action :return_current_user_to_admin, only: [:home]

  def home
    @users = User.where(admin: false)
		@list_stats = list_stats
		@user_with = user_stats
		@task_stats = task_stats
  end

  def log_in_as
    @user = User.find(params[:id])
    if !admin_masquerade?
      session[:admin_id] = current_user.id
    end
    log_out
    log_in(@user)
    direct_user(@user)
  end

	def search
		results = check_search_options(params)
		render json: { list_results: results["lists"], task_results: results["tasks"] }
	end
end
