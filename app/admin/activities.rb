ActiveAdmin.register Activity do
  menu priority: 7
  permit_params

  index do
    column :user_email
    column :action
    column :url_previous_page
    column :url_page
    column :created_at
    actions
  end
end