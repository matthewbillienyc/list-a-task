module ApplicationHelper
  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this."
      redirect_to root_path
    end
  end
end
