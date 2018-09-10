class Lesson < ApplicationRecord
  validates :user_id, uniqueness: { scope: :category_id }
  validates :user_id, presence: true 
  validates :category_id, presence: true
  has_many :lesson_words, dependent: :destroy
  has_many :word_answers, through: :lesson_words
  belongs_to :user
  belongs_to :category
end
