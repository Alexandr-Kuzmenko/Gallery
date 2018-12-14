ActiveAdmin.register Category do

  permit_params :name
  menu priority: 3
  includes :wallpapers

  controller do
    # Need to pass slug-friendly-id in active_admin
    before_action :load_category, only: [:show, :edit, :update, :destroy]

    private

    # Need to pass slug-friendly-id active_admin
    def load_category
      @category = Category.friendly.find(params[:id])
    end
  end

  index do
    selectable_column
    column :name
    column :id
    column :categorized
    column :created_at
    column :updated_at
    column :locked
    column :wallpapers_count
    actions
  end

  form partial: 'form'
  # form do |f|
  #   f.inputs "Category Edit" do
  #     f.input :name, label: 'Name:'
  #     f.input :locked
  #   end
  #   f.actions
  # end
end
