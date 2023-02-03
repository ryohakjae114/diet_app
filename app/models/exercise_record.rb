class ExerciseRecord < ApplicationRecord
  belongs_to :user
  
  validates :kcal, presence: true, numericality: true
end
