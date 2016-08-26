class CreateUserDays < ActiveRecord::Migration
  def change
    create_table :user_days do |t|
      t.integer :user_id
      t.integer :day_id
      t.timestamps null: false
    end
  end
end
