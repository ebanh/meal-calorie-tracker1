class UserDayMeal < ActiveRecord::Base

  belongs_to :user
  belongs_to :meal
  belongs_to :day
end
