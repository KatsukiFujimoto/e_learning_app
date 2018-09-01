class WordAnswer < ApplicationRecord
  validates :content, presence: true
  validates :correct, presence: true
  validates :word_id, presence: true
  belongs_to :word
end
