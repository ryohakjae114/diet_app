class AddColumnUserIdToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :user_id, :uuid

    add_foreign_key :items, :users
    add_index :items, :user_id
  end
end
