class NumberOfDigitsOnRecipeGroup < ActiveRecord::Migration[6.0]
  def change
    change_column :items, :kcal, :decimal, precision: 8, scale: 3, default: 0.0
    change_column :items, :protein, :decimal, precision: 8, scale: 3, default: 0.0
    change_column :items, :fat, :decimal, precision: 8, scale: 3, default: 0.0
    change_column :items, :carb, :decimal, precision: 8, scale: 3, default: 0.0
    change_column :items, :df, :decimal, precision: 8, scale: 3, default: 0.0
    change_column :items, :weight, :decimal, precision: 8, scale: 3, default: 0.0


    change_column :recipes, :protein, :decimal, precision: 8, scale: 3, default: 0.0
    change_column :recipes, :fat, :decimal, precision: 8, scale: 3, default: 0.0
    change_column :recipes, :carb, :decimal, precision: 8, scale: 3, default: 0.0
    change_column :recipes, :df, :decimal, precision: 8, scale: 3, default: 0.0
    change_column :recipes, :kcal, :decimal, precision: 8, scale: 3, default: 0.0

    change_column :recipe_items, :kcal, :decimal, precision: 8, scale: 3, default: 0.0
    change_column :recipe_items, :weight, :decimal, precision: 8, scale: 3, default: 0.0

  end
end
