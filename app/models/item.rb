class Item < ApplicationRecord
  validates :name, presence: true
  validates :kcal, presence: true, numericality: true
  validates :protein, presence: true, numericality: true
  validates :fat, presence: true, numericality: true
  validates :carb, presence: true, numericality: true
  validates :df, presence: true, numericality: true
  validates :around_qty, presence: true
end
