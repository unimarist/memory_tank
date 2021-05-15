class Word < ApplicationRecord
  belongs_to :tank 
  belongs_to :user

  def self.learned(id)
    Word.where("tank_id = ?",id).where("correct_rate >= ?",70)
  end

  def self.unlearned(id)
    Word.where("tank_id = ?",id).where("correct_rate < ?",70)
  end

  def self.search(id,key,word_level)
    if key != ""
      if word_level == "未習得Word :"
        Word.where("tank_id = ?",id).where('word LIKE(?)', "%#{key}%").where("correct_rate < ?",70)
      elsif word_level == "習得済Word :"
        Word.where("tank_id = ?",id).where('word LIKE(?)', "%#{key}%").where("correct_rate >= ?",70)
      end
    end 
  end
end
