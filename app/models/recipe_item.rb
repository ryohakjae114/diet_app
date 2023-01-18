class RecipeItem < ApplicationRecord
  belongs_to :item
  belongs_to :recipe

  validates :item_id, uniqueness: { scope: :recipe_id }
end
