class Comment < ApplicationRecord
  belongs_to :author, foreign_key: :author_id, class_name: 'User'
  belongs_to :post, counter_cache: :commentscounter

  after_save :update_post_comments_counter
  

  def update_post_comments_counter
    post.increment!(:commentscounter)
  end
  private :update_post_comments_counter
end
