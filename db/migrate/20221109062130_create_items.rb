class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :kcal
      t.decimal :protein
      t.decimal :fat
      t.decimal :carb
      t.decimal :df
      t.string :around_qty

      t.timestamps
    end
  end
end
