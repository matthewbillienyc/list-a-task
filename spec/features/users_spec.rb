require 'rails_helper'

feature "User management" do
  scenario "signs up user" do
    visit signup_path
    fill_in 'Username', with: "mrbillie"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    click_button 'Create User'

    expect(page).to have_content 'Welcome to the App!'
  end

  scenario "logs in user" do
    user = create(:user)
    visit login_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Log In'

    expect(page).to have_content 'Welcome back!'
  end

  scenario "logs out user" do
    user = create(:user)
    visit login_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Log In'
    click_link 'Log Out'

    expect(page).to have_content 'Goodbye!'
  end
end
