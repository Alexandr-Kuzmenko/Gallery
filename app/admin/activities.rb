ActiveAdmin.register Activity do
  menu priority: 7
  permit_params

  index do
    column :user
    column :action
    column :url_page
    column :created_at
    actions
  end
end