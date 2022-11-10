class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.references :item, null: false, foreign_key: true
      t.decimal :kcal
      t.decimal :weight

      t.timestamps
    end
  end
end
