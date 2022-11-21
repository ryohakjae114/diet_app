class AddKcalToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :kcal, :decimal
  end
end
