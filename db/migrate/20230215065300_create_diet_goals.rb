class CreateDietGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :diet_goals do |t|
      t.uuid :user_id, null: false
      t.decimal :weight, precision: 6, scale: 2, default: 0.0
      t.date :date

      t.timestamps
    end
    add_foreign_key :diet_goals, :users
    add_index :diet_goals, :user_id
  end
end
