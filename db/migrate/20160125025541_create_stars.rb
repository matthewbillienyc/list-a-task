class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.integer :starable_id
      t.string :starable_type

      t.timestamps null: false
    end
  end
end
