class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.date :date
      t.string :meal_time
      t.timestamps null: false
    end
  end
end
