module LoginMacros
  def sign_in(user)
    visit root_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Log In'
  end
end
