class AddIndexesForUniqueColumnsInAdminUser < ActiveRecord::Migration[5.2]
  def change
    add_index :admin_users, :nickname, unique: true, name: "index_admin_users_on_nickname"
  end
end
