require 'rails_helper'

feature "Add Lists and tasks, delete them, and star and unstar them" do
  scenario "a user can add lists to his/her show page", js: true do
    user = create(:user)
    sign_in(user)
    expect(page).to have_content "Welcome back!"

    fill_in 'List Name', with: "To Do"
    click_button 'Add List'
    expect(page).to have_content "To Do"

    select('To Do', from: 'Select List:')
    select('medium', from: 'Priority Level:')
    fill_in 'description', with: "Do chores"
    click_button 'Add Task'
    expect(page).to have_content "Do chores"

    find('div.list-group-item #star-btn .btn').click
    find('#unstar-btn')

    find('li.task .star-span .btn').click
    find('li.task .star-span #unstar-btn')

    find('.delete-task .btn').click
    expect(page).not_to have_content "Do chores"

    find('.delete-list .btn').click
    expect(page).not_to have_content "To Do"
    expect(page).not_to have_content "Select List:"
  end
end
