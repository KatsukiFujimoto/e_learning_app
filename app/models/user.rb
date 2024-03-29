class User < ApplicationRecord
  has_many :activities, dependent: :destroy
  has_one :passive_user, through: :activities, source: :passive_user
  has_many :lessons, dependent: :destroy 
  has_many :lesson_words, through: :lessons
  has_many :categories, through: :lessons
  has_many :active_relationships, class_name: "Relationship",
                                foreign_key: "follower_id",
                                dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                foreign_key: "followed_id",
                                dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  attr_accessor :remember_token
  before_save { self.email.downcase! }  #selfは省略可能
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  
  class << self
    # 渡された文字列のハッシュ値を返す
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
    
    # ランダムなトークンを返す
    def new_token
      SecureRandom.urlsafe_base64
    end
  end
  
  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
    self.activities.create(action_type: "followed", passive_user_id: other_user.id)
  end
  
  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
    self.activities.create(action_type: "unfollowed", passive_user_id: other_user.id)
  end
  
  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
  
  def activity_feed 
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    # active_activity = Activity.where("user_id IN (#{following_ids})
    #               OR user_id = :user_id", user_id: self.id)
    # passive_activity = Activity.where("passive_user_id IN (#{following_ids})
    #               OR passive_user_id = :user_id", user_id: self.id)
    # active_activity + passive_activity
    
    Activity.where("user_id IN (#{following_ids}) OR user_id = :user_id
                    OR passive_user_id IN (#{following_ids}) OR passive_user_id = :user_id",
                    user_id: self.id)
  end
  
  def show_activity 
    Activity.where("user_id = :user_id OR passive_user_id = :user_id",
            user_id: self.id)
  end
end
