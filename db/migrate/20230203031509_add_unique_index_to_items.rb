class AddUniqueIndexToItems < ActiveRecord::Migration[6.0]
  def change
    remove_index :items, :name
    add_index :items, [:name, :user_id], unique: true
  end
end
