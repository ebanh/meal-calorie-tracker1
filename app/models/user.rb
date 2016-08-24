class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username
  validates_presence_of :email
  validates_presence_of :password

  has_many :user_day_meals
  has_many :meals, through: :user_day_meals
  has_many :days, through: :user_day_meals
end
