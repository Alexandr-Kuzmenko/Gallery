ActiveAdmin.register Category do
  includes :wallpapers
  menu priority: 3
  permit_params :name, :locked
  index do
    selectable_column
    column :name
    column :id
    column :categorized_id
    column :categorized_type
    column :created_at
    column :updated_at
    column :locked
    actions
  end

  controller do
    before_action :load_category, only: [:show, :edit, :update, :destroy]
    def create
      category = current_admin_user.categories.new(category_params)
      if category.save
        redirect_to admin_categories_path
      else
        render :new
      end
    end

    def update
      if @category.update_attributes(category_params)
        redirect_to admin_categories_path
      else
        render :edit
      end
    end

    private

    def load_category
      @category = Category.friendly.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :locked)
    end
  end
  #form partial: 'form'
  form do |f|
    f.inputs "Category Edit" do
      f.input :name, label: 'Name:'
      f.input :locked
    end
    f.actions
  end
end
