class CreateAchivements < ActiveRecord::Migration[5.0]
  def change
    create_table :achivements do |t|
      t.references :habit
      t.date :date
      t.boolean :completed, default: false
      t.text :memo
    end
  end
end
