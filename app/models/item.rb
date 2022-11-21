class Item < ApplicationRecord
  has_many :recipe_items
  has_many :recipes, through: :recipe_items

  validates :name, presence: true, uniqueness: true
  validates :kcal, presence: true, numericality: true
  validates :protein, presence: true, numericality: true
  validates :fat, presence: true, numericality: true
  validates :carb, presence: true, numericality: true
  validates :df, presence: true, numericality: true
  validates :unit, presence: true
  validates :weight, presence: true, numericality: true
end
