class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  has_many :favorite_posts, dependent: :destroy
  has_many :favorite_post_images, through: :favorite_posts, source: :post

  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  mount_uploader :icon, IconUploader
  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true, length: {maximum: 255},   format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :icon, presence: true
  before_validation { email.downcase! }

  has_secure_password

  validates :password, presence: true, length: {minimum: 6}

  def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end

  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
end
