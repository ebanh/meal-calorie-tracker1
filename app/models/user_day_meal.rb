class UserDayMeal < ActiveRecord

  belongs_to :user
  belongs_to :meal
  belongs_to :day
end
