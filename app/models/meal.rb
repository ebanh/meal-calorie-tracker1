class Meal < ActiveRecord::Base

  has_many :user_day_meals
  has_many :users, through: :user_day_meals
  has_many :days, through: :user_day_meals
end
