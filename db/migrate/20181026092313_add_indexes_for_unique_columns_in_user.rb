class AddIndexesForUniqueColumnsInUser < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :nickname, unique: true, name: "index_users_on_nickname"
  end
end
