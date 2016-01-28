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
    sign_in(user)
    expect(page).to have_content 'Welcome back!'
  end

  scenario "logs out user" do
    user = create(:user)
    sign_in(user)
    click_link 'Log Out'
    expect(page).to have_content 'Goodbye!'
  end  
end
