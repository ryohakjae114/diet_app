class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :img_url
      t.string :name
      t.decimal :protein
      t.decimal :fat
      t.decimal :carb
      t.decimal :df
      t.string :type

      t.timestamps
    end
  end
end
