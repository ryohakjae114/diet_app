class CreateDiaries < ActiveRecord::Migration[6.0]
  def change
    create_table :diaries do |t|
      t.uuid :user_id, null: false
      t.string :introduction
      t.string :icon
      t.boolean :public_diary
      t.boolean :public_body
      t.boolean :activate

      t.timestamps
    end
    add_foreign_key :diaries, :users
    add_index :diaries, :user_id
  end
end
