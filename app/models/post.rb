class Post < ApplicationRecord
  belongs_to :author, foreign_key: :author_id, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_save :update_author_posts_counter

  validates :title, presence: true, length: { maximum: 100 }
  validates :commentscounter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  validates :likescounter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  def update_author_posts_counter
    author.increment!(:postscounter)
  end

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
  private :update_author_posts_counter
end
