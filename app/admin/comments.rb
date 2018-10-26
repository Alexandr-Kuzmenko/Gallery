ActiveAdmin.register Comment, as: 'User_Comment' do
  permit_params :title, :text, :image
  menu priority: 5
  index do
    column :user_id
    column :text
    column :wallpaper_id
    column :created_at
    column :updated_at
    actions
  end
end
