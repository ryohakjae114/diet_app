class MealMenu < ApplicationRecord
  belongs_to :meal
  belongs_to :recipe

  validates :count, presence: true, numericality: { less_than_or_equal_to: 100 }

end
