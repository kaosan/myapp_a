class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :content, presence: true
  validates :image, presence: true
  belongs_to :user
  has_many :favorite_posts, dependent: :destroy
  has_many :favorite_post_users, through: :favorite_posts, source: :user
  has_many :comments, dependent: :destroy

end
