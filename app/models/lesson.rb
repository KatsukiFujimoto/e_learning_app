class Lesson < ApplicationRecord
  validates :user_id, uniqueness: { scope: :category_id }
  validates :user_id, presence: true 
  validates :category_id, presence: true
  belongs_to :user
  belongs_to :category
end
