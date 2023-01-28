class CreateMealMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :meal_menus do |t|
      t.references :meal, null: false, foreign_key: true, index: true
      t.references :recipe, null: false, foreign_key: true, index: true
      t.integer :count

      t.timestamps
    end
  end
end
