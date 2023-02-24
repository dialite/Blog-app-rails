class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, foreign_key: :post_id
  has_many :likes, foreign_key: :post_id

  def update_counter
    author.update(posts_counter: author.posts.count)
  end
  after_save :update_counter

  def recent_comments
    comments.includes(:post).limit(5).order(created_at: :DESC)
  end
end
