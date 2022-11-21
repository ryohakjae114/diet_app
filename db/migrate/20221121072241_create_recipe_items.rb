class CreateRecipeItems < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_items do |t|
      t.reference :recipe, index: true
      t.reference :item, index: true
      t.kcal :decimal
      t.weight :decimal

      t.timestamps
    end
  end
end
