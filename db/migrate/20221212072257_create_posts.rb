class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.uuid :user_id, null: false
      t.text :text

      t.timestamps
    end
    add_foreign_key :posts, :users
    add_index :posts, :user_id
  end
end
