class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text :question
      t.text :answer_a
      t.text :answer_b
      t.text :answer_c
      t.text :answer_d
      t.text :correct_answer
      t.text :description
      t.integer :correct_count
      t.integer :uncorrect_count
      t.float :correct_rate
      t.integer :user_id
      t.integer :tank_id
      t.timestamps
    end
  end
end
