class Tank < ApplicationRecord
  belongs_to :user
  has_many :words,dependent: :destroy
  has_many :questions,dependent: :destroy
  has_one_attached :tank_icon
  validates :tank_name, presence: true, length: { maximum: 30 }

  def self.word_tank_search(current_user_id)
      Tank.where("tank_type = ?", "単語").where("user_id = ?", current_user_id)
  end

  def self.question_tank_search(current_user_id)
      Tank.where("tank_type = ?", "問題").where("user_id = ?", current_user_id)
  end
  
end