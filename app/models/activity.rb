class Activity < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :passive_user, class_name: "User", optional: true
  validates :action_type, presence: true
  validates :user_id, presence: true 
end
