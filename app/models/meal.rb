class Meal < ApplicationRecord
  belongs_to :user
  has_many :meal_menus

  enum timing: { morning: 0, lunch: 1, dinner: 2 }
end
