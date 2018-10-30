class AddNicknameAndAvatarToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nickname, :string
    add_index :users, :nickname, unique: true, name: "index_users_on_nickname"
    add_column :users, :avatar, :string
  end
end
