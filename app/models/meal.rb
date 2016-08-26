class Meal < ActiveRecord::Base

  belongs_to :user
  has_many :days, through: :user

  validates_presence_of :name
  validates_presence_of :calories
end
