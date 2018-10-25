ActiveAdmin.register AdminUser do
  permit_params :email, :encrypted_password, :password_confirmation
  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    actions
  end

  controller do
    def show
      load_admin_user
    end

    def create
      @admin_user = AdminUser.new(admin_user_params)
      @admin_user.save ? redirect_to(admin_admin_users_path) : (render :new)
    end

    def update
      @admin_user = load_admin_user
      @admin_user.update_attributes(admin_user_params) ? redirect_to(admin_admin_users_path) : (render :edit)
    end

    private

    def admin_user_params
      params.require(:admin_user).permit(:email, :password, :password_confirmation)
    end

    def load_admin_user
      @admin_user = AdminUser.find(params[:id])
    end
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
