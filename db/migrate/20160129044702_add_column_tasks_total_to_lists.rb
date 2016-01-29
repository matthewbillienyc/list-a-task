class AddColumnTasksTotalToLists < ActiveRecord::Migration
  def change
    add_column :lists, :tasks_total, :integer, default: 0
  end
end
