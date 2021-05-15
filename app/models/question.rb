class Question < ApplicationRecord
  belongs_to :tank 
  belongs_to :user
  validates :question, presence: true, uniqueness: true,length: { maximum: 500 }
  validates :answer_a, presence: true, length: { maximum: 500 }
  validates :answer_b, presence: true, length: { maximum: 500 }
  validates :answer_c, presence: true, length: { maximum: 500 }
  validates :answer_d, presence: true, length: { maximum: 500 }
  validates :correct_answer, presence: true, length: { maximum: 500 }
  validates :description, presence: true, length: { maximum: 500 }

  def self.learned(id)
    Question.where("tank_id = ?",id).where("correct_rate >= ?",70)
  end

  def self.unlearned(id)
    Question.where("tank_id = ?",id).where("correct_rate < ?",70)
  end



end
