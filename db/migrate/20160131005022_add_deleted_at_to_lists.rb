class AddDeletedAtToLists < ActiveRecord::Migration
  def change
    add_column :lists, :deleted_at, :time
  end
end
