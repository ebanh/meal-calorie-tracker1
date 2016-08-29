class DayMeal < ActiveRecord::Base

  belongs_to :meal
  belongs_to :day
end
