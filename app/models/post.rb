class Post < ApplicationRecord
  has_many :comments
  has_many :likes

  belongs_to :author, class_name: 'User'

  def update_post_counter
    author.increment!(:posts_counter)
  end

  def recent_comments
    comments.limit(5).order(created_at: :desc)
  end
end
