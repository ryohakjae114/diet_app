class RenameRecipeIdIdColumnToMySetRecipes < ActiveRecord::Migration[6.0]
  def change
    rename_column :my_set_recipes, :recipe_id_id, :recipe
  end
end
