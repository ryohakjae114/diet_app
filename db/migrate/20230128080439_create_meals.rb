class CreateMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :meals do |t|
      t.uuid :user_id
      t.date :date
      t.integer :timing
      t.string :comment

      t.timestamps
    end
    add_foreign_key :meals, :users
    add_index :meals, :user_id
  end
end
