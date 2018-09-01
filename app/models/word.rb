class Word < ApplicationRecord
  belongs_to :category
  has_many :word_answers, inverse_of: :word
  accepts_nested_attributes_for :word_answers  
  validates :content, presence: true
  validates :category_id, presence: true

end
