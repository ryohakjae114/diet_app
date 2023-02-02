class RemoveRecipeFromMySetRecipes < ActiveRecord::Migration[6.0]
  def change
    remove_column :my_set_recipes, :recipe, :integer
  end
end
