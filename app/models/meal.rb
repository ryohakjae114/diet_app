class Meal < ApplicationRecord
  belongs_to :user

  enum timing: { morning: 0, lunch: 1, dinner: 2 }
end
