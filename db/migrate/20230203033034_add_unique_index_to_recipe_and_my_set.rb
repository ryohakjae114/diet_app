class AddUniqueIndexToRecipeAndMySet < ActiveRecord::Migration[6.0]
  def change
    add_index :recipes, [:name, :user_id], unique: true
    add_index :my_sets, [:name, :user_id], unique: true
  end
end
