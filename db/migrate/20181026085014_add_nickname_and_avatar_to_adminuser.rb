class AddNicknameAndAvatarToAdminuser < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :nickname, :string
    add_index :admin_users, :nickname, unique: true, name: "index_admin_users_on_nickname"
    add_column :admin_users, :avatar, :string
  end
end
