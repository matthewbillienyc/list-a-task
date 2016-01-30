module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def admin?
    current_user.admin == true
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

  def direct_user(user)
    if admin?
      redirect_to admin_path
    else
      flash[:success] = "Welcome back!"
      redirect_to user
    end
  end

  def verify_logged_out
    unless !logged_in?
      flash[:danger] = "You must be logged out to access this"
      redirect_to user_path(current_user)
    end
  end

  def verify_logged_in
    unless logged_in?
      flash[:danger] = "You must be logged in to access this"
      redirect_to root_url
    end
  end

  def verify_user
    unless current_user == User.find(params[:id]) || current_user.admin == true
      flash[:danger] = "You cannot view another user's lists."
      redirect_to user_path(current_user)
    end
  end
end
