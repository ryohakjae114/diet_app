class AddPostToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :date, :date
    add_index :posts, [:user_id, :date], unique: true
  end
end
