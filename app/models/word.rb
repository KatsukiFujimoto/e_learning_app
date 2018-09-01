class Word < ApplicationRecord
  validates :content, presence: true
  validates :category_id, presence: true
  belongs_to :category
  has_many :word_answers
end
