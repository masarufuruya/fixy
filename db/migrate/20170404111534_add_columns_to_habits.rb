class AddColumnsToHabits < ActiveRecord::Migration[5.0]
  def change
    add_column :habits, :purpose, :string
    add_column :habits, :goal, :string
  end
end
