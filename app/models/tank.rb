class Tank < ApplicationRecord
  belongs_to :user
  has_many :words
  has_many :questions
  has_one_attached :tank_icon
  validates :tank_name, presence: true, length: { maximum: 30 }

  def self.word_search(current)
      Tank.where("tank_type = ?", "単語").where("user_id = ?", current)
  end

  def self.question_search(current)
    Tank.where("tank_type = ?", "問題").where("user_id = ?", current)
  end


end
