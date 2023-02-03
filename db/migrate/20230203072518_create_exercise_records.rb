class CreateExerciseRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :exercise_records do |t|
      t.string :name
      t.decimal :kcal, precision: 7, scale: 3
      t.uuid :user_id, null: false

      t.timestamps
    end

    add_foreign_key :exercise_records, :users
    add_index :exercise_records, :user_id
  end
end
