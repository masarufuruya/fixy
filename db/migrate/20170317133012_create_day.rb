class CreateDay < ActiveRecord::Migration[5.0]
  def change
    create_table :days do |t|
      t.string :name
    end
  end
end
