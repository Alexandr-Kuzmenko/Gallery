ActiveAdmin.register Activity do
  menu priority: 6
  permit_params

  index do
    selectable_column
    column :user
    column :action_type
    column :url_page
    column :created_at
    actions
  end
end