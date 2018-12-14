ActiveAdmin.register Activity do

  actions :all, except: [:new, :create, :edit, :update]
  menu priority: 7

  index do
    selectable_column
    column :user
    column :action_type
    column :url_page
    column :created_at
    actions
  end
end