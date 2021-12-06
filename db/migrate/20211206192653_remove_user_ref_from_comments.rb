class RemoveUserRefFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_reference :comments, :user, null: false, foreign_key: true
  end
end
