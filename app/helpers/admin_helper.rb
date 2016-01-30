module AdminHelper
  def verify_admin
    unless logged_in? && current_user.admin == true
      flash[:danger] = "You do not have admin access"
      redirect_to root_url
    end
  end
end
