class AddDeletedAtToStars < ActiveRecord::Migration
  def change
    add_column :stars, :deleted_at, :time
  end
end
