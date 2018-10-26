ActiveAdmin.register Wallpaper do
  includes :comments
  menu priority: 4
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

  controller do
    def create
      @wallpaper = Wallpaper.new(wallpaper_params)
      @wallpaper.save ? redirect_to(admin_wallpapers_path) : (render :new)
    end

    def update
      @wallpaper = Category.find(params[:id])
      @wallpaper.update_attributes(wallpaper_params) ? redirect_to(admin_wallpapers_path) : (render :edit)
    end

    private

    def wallpaper_params
      params.require(:category).permit(:name)
    end
  end

  form do |f|
    f.inputs "Wallpaper Edit" do
      f.input :title
      f.input :category_id
    end
    f.actions
  end
end