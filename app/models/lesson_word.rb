class LessonWord < ApplicationRecord
  validates :lesson_id, presence: true
  validates :word_id, presence: true
  validates :word_answer_id, presence: true
  belongs_to :lesson
  belongs_to :word
  belongs_to :word_answer
end
