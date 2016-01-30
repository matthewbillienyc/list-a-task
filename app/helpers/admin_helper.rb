module AdminHelper
  def verify_admin
    unless logged_in? && (current_user.admin == true || session[:admin_id])
      flash[:danger] = "You do not have admin access"
      redirect_to root_url
    end
  end

  def return_current_user_to_admin
    if admin_masquerade?
      log_out
      session[:user_id] = session[:admin_id]
    end
  end
end
