module LoginMacros
  def sign_in(user)
    visit login_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Log In'
  end

  def log_in(user)
    @current_user = user
  end

  def current_user
    @current_user
  end
end
