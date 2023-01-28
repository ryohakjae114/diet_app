class MealMenu < ApplicationRecord
  belongs_to :meal
  belongs_to :recipe_id
end
