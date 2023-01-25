class AddColumnUserIdToRecipe < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :user_id, :uuid

    add_foreign_key :recipes, :users
    add_index :recipes, :user_id
  end
end
