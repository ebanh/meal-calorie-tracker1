class CreateDayMeals < ActiveRecord::Migration
  def change
    create_table :day_meals do |t|
      t.integer :day_id
      t.integer :meal_id
      t.timestamps null: false
    end
  end
end
