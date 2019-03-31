
class Post < ApplicationRecord
  belongs_to :user
  has_many :favorite_posts, dependent: :destroy
  has_many :favorite_post_users, through: :favorite_posts, source: :user
  has_many :comments, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  mount_uploader :image, ImageUploader
  validates :content, presence: true
  validates :image, presence: true

  def user
    return User.find_by(id: self.user_id)
  end

end
