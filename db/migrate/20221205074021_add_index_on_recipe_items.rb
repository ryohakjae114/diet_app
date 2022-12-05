class AddIndexOnRecipeItems < ActiveRecord::Migration[6.0]
  def change
    add_index :recipe_items, [:recipe_id, :item_id], unique: true
  end
end
