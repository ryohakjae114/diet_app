class Meal < ApplicationRecord
  belongs_to :user
  has_many :meal_menus

  enum timing: { morning: 0, lunch: 1, dinner: 2 }

  validates :date,   presence: true
  validates :timing, presence: true
  validates :comment,length: { maximum: 200 }
end
