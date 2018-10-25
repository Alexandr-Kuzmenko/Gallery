ActiveAdmin.register Category do
  includes :wallpapers
  permit_params :name, :locked, :user_id
  index do
    column :name
    column :id
    column :user_id
    column :created_at
    column :updated_at
    column :locked
    actions
  end

  controller do
    def create
      @category = User.find(1).categories.new(category_params)
      @category.save ? redirect_to(admin_categories_path) : (render :new)
    end

    def update
      @category = Category.find(params[:id])
      @category.update_attributes(category_params) ? redirect_to(admin_categories_path) : (render :edit)
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end

  end

  form do |f|
    f.inputs "Category Edit" do
      f.input :name
      f.input :locked
    end
    f.actions
  end
end
