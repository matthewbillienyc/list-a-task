class RemoveTotalsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :lists_total, :integer
    remove_column :users, :tasks_total, :integer
    remove_column :users, :stars_total, :integer
  end
end
