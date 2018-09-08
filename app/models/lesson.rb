class Lesson < ApplicationRecord
  validates :user_id, presence: true 
  validates :category_id, presence: true
  belongs_to :user
  belongs_to :category
end
