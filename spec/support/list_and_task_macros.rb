module ListAndTaskMacros
  def add_list
    fill_in 'List Name', with: "To Do"
    click_button 'Add List'
  end

  def add_task
    select('To Do', from: 'List')
    select('medium', from: 'Priority')
    fill_in 'description', with: "Do chores"
    click_button 'Add Task'
  end

  def star_list
  end

  def star_task
  end
end
