class WordAnswer < ApplicationRecord
  belongs_to :word, inverse_of: :word_answers
  validates :content, presence: true
  # validates :word_id, presence: true
end
