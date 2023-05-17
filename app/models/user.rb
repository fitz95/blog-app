class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :author_id, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :bio, length: { maximum: 200 }
  validates :photo, format: { with: %r{\Ahttps?://.*\z} }
  validates :postscounter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  def most_three_recent_posts
    posts.order(created_at: :asc).limit(3)
  end
end
