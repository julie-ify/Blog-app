class RemoveUserRefFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_reference :posts, :user, null: false, foreign_key: true
  end
end
