class CreateMySetRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :my_set_recipes do |t|
      t.references :recipe_id
      t.integer :count

      t.timestamps
    end
  end
end
