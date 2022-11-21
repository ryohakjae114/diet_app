class ChangeDatatypeTypeOfRecipes < ActiveRecord::Migration[6.0]
  def change
    change_column :recipes, :type, "integer USING CAST(type AS integer)"
  end
end
