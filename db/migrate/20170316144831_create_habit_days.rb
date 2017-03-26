class CreateHabitDays < ActiveRecord::Migration[5.0]
  def change
    create_table :habit_days do |t|
      t.integer :habit_id
      t.integer :day_id
      t.boolean :checked, default: false
      t.timestamps
    end
  end
end
