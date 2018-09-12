class Category < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  has_many :words, dependent: :destroy
  has_many :lessons, dependent: :destroy
end
