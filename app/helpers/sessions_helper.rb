module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def logged_in?
    !current_user.nil?
  end

  def verify_user
    unless current_user == User.find(params[:id])
      flash[:logged_in] = "You cannot view another user's lists."
      redirect_to user_path(current_user)
    end
  end
end
