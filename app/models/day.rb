class Day < ActiveRecord::Base

  belongs_to :user
  has_many :day_meals
  has_many :meals, through: :day_meals

  validates_presence_of :date
  validates_presence_of :meal_time
end
