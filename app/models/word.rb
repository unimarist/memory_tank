class Word < ApplicationRecord
  belongs_to :tank 
  belongs_to :user
  validates :word, presence: true, uniqueness: true,length: { maximum: 100 }
  validates :meaning, presence: true, length: { maximum: 500 }

  def self.learned(tank_id)
    Word.where("tank_id = ?",tank_id).where("correct_rate >= ?",70)
  end

  def self.unlearned(tank_id)
    Word.where("tank_id = ?",tank_id).where("correct_rate < ?",70)
  end

  def self.search(tank_id,search_key,word_level)
    if word_level == "未習得Word :"
      Word.where("tank_id = ?",tank_id).where('word LIKE(?)', "%#{search_key}%").where("correct_rate < ?",70)
    elsif word_level == "習得済Word :"
      Word.where("tank_id = ?",tank_id).where('word LIKE(?)', "%#{search_key}%").where("correct_rate >= ?",70)
    end
  end 

end