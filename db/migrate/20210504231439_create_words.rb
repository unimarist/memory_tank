class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.integer :user_id
      t.integer :tank_id
      t.string :word
      t.string :meaning
      t.integer :correct_count
      t.integer :uncorrect_count
      t.integer :correct_rate
      t.timestamps
    end
  end
end
