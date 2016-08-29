class Meal < ActiveRecord::Base

  has_many :day_meals
  has_many :days, through: :day_meals

  validates_presence_of :name
  validates_presence_of :calories
end
