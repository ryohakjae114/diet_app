class AddReferencesToMySetRecipes < ActiveRecord::Migration[6.0]
  def change
    add_reference :my_set_recipes, :recipe, null: false, foreign_key: true
  end
end
