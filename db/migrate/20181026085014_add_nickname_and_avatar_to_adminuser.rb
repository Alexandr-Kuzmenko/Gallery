class AddNicknameAndAvatarToAdminuser < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :nickname, :string
    add_column :admin_users, :avatar, :string
  end
end
