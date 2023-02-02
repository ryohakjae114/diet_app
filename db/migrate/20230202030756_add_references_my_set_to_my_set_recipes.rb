class AddReferencesMySetToMySetRecipes < ActiveRecord::Migration[6.0]
  def change
    add_reference :my_set_recipes, :my_set, null: false, foreign_key: true
  end
end
