class CreateMemos < ActiveRecord::Migration[5.0]
  def change
    create_table :memos do |t|
      t.string :body
      t.references :habit
      t.references :achivement 
      t.timestamps
    end
  end
end
