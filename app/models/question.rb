class Question < ApplicationRecord
  belongs_to :tank 
  belongs_to :user

  def self.learned(id)
    Question.where("tank_id = ?",id).where("correct_rate >= ?",70)
  end

  def self.unlearned(id)
    Question.where("tank_id = ?",id).where("correct_rate < ?",70)
  end



end
