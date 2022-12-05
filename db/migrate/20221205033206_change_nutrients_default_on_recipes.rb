class ChangeNutrientsDefaultOnRecipes < ActiveRecord::Migration[6.0]
  def change
    change_column :recipes, :protein, :decimal, default: 0.0
    change_column :recipes, :fat,     :decimal, default: 0.0
    change_column :recipes, :carb,    :decimal, default: 0.0
    change_column :recipes, :df,      :decimal, default: 0.0
  end
end
