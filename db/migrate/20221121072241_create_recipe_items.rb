class CreateRecipeItems < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_items do |t|
      t.references :recipe, index: true
      t.references :item, index: true
      t.decimal :kcal
      t.decimal :weight

      t.timestamps
    end
  end
end
