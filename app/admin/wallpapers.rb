ActiveAdmin.register Wallpaper do
  includes :comments
  permit_params :title, :category_id, :image
  index do
    column :title
    column :id
    column :category_id
    column :created_at
    column :updated_at
    actions
  end
  index as: :grid do |wallpaper|
    link_to image_tag(wallpaper.image.mini_thumb.url), admin_wallpaper_path(wallpaper)
  end

  form do |f|
    f.inputs "Wallpaper Edit" do
      f.input :title
      f.input :category_id
    end
    f.actions
  end
end