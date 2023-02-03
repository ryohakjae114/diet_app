class AddUniqueIndexToMeal < ActiveRecord::Migration[6.0]
  def change
    add_index :meals, [:date, :timing], unique: true
  end
end
