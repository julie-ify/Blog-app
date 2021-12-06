class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def update_likes_counter
    post.increment!(:likes_counter)
  end
end
