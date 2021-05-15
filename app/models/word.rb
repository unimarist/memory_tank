class Word < ApplicationRecord
  belongs_to :tank 
  belongs_to :user
  validates :word, presence: true, uniqueness: true,length: { maximum: 30 }
  validates :meaning, presence: true, length: { maximum: 120 }


  def self.learned(id)
    Word.where("tank_id = ?",id).where("correct_rate >= ?",70)
  end

  def self.unlearned(id)
    Word.where("tank_id = ?",id).where("correct_rate < ?",70)
  end

  def self.search(id,key,word_level)
      if word_level == "未習得Word :"
        Word.where("tank_id = ?",id).where('word LIKE(?)', "%#{key}%").where("correct_rate < ?",70)
      elsif word_level == "習得済Word :"
        Word.where("tank_id = ?",id).where('word LIKE(?)', "%#{key}%").where("correct_rate >= ?",70)
      end
    end 
end
