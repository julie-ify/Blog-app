class AddUserRefToLikes < ActiveRecord::Migration[6.1]
  def change
    add_reference :likes, :author, foreign_key: { to_table: :users }
  end
end
