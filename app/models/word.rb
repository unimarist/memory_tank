class Word < ApplicationRecord
  belongs_to :tank 
  belongs_to :user

  def self.learned(id)
    Word.where("tank_id = ?",id).where("correct_rate >= ?",70)
  end

  def self.unlearned(id)
    Word.where("tank_id = ?",id).where("correct_rate < ?",70)
  end


end
