class AddStarsTotalToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stars_total, :integer, default: 0
  end
end
