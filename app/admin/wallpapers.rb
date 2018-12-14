ActiveAdmin.register Wallpaper do

  permit_params :title
  menu priority: 4
  includes :comments

  controller do
    before_action :load_categories, only: [:new, :create, :edit, :update, :show]
    before_action :load_wallpaper, only: [:show, :edit, :update, :destroy]

    private

    def load_wallpaper
      @wallpaper = Wallpaper.friendly.find(params[:id])
    end

    def load_categories
      @categories = Category.all
    end
  end

  index do
    selectable_column
    column :title
    column :id
    column :category_id
    column :created_at
    column :updated_at
    column :likes_count
    actions
  end

  index as: :grid do |wallpaper|
    ul do
      li image_tag(wallpaper.image.thumb.url, alt: 'image')
      li link_to "GOTO --> #{wallpaper.title}", wallpaper_path(wallpaper), class: "button", target: '_blank'
    end
  end

  form partial: 'form'
end