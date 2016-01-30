class AddListsAndTasksTotalToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lists_total, :integer, default: 0
    add_column :users, :tasks_total, :integer, default: 0
    add_column :users, :admin, :boolean, default: false
  end
end
