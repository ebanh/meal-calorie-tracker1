class Day < ActiveRecord

  has_many :user_day_meals
  has_many :meals, through: :user_day_meals
  has_many :users, through: :user_day_meals
end
