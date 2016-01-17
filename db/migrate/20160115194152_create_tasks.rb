class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :list_id
      t.string :priority
      t.string :description

      t.timestamps null: false
    end
  end
end
