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
    column :likes_count
    actions
  end

  show do
    # renders app/views/admin/posts/_some_partial.html.erb
    render 'form', { wallpaper: wallpaper }
  end


  index as: :grid do |wallpaper|
    link_to image_tag(wallpaper.image.mini_thumb.url), admin_wallpaper_path(wallpaper)
  end

  controller do
    before_action :load_categories, only: [:new, :create, :edit, :update]

    def create
      @wallpaper = Wallpaper.new(wallpaper_params)
      if @wallpaper.save
        redirect_to admin_wallpapers_path
      else
        render :new
      end
    end

    def update
      @wallpaper = Category.find(params[:id])
      if @wallpaper.update_attributes(wallpaper_params)
        redirect_to admin_wallpapers_path
      else
        render :edit
      end
    end

    private

    def wallpaper_params
      params.require(:wallpaper).permit(:title, :category_id, :image)
    end

    def load_categories
      @categories = Category.all
    end
  end
  form partial: 'form'
end