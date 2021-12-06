class RemoveColumnFromLikes < ActiveRecord::Migration[6.1]
  def change
    remove_column(:likes, :user_id, if_exists: true)
  end
end
