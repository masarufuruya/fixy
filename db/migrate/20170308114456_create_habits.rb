class CreateHabits < ActiveRecord::Migration[5.0]
  def change
    create_table :habits do |t|
      t.string :name, null: false
      # foreign_keyは強力すぎる。開発中はやめる
      t.references :user
      t.date :start_date
      t.date :end_date
    end
  end
end
