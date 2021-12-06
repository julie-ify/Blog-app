class RemoveJoinTable < ActiveRecord::Migration[6.1]
  def change
    drop_join_table :users, :posts, table_name: :likes
  end
end
