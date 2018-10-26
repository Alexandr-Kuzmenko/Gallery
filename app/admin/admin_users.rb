ActiveAdmin.register AdminUser do
  menu priority: 2
  #permit_params :email, :encrypted_password, :password_confirmation
  permit_params do
    permitted = [:encrypted_password, :password_confirmation, :nickname, :avatar]
    permitted << :email if params[:action] == 'create'
    permitted
  end

  index do
    column :email
    column :nickname
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
      params.require(:admin_user).permit(:email, :password, :password_confirmation, :nickname)
    end

    def load_admin_user
      @admin_user = AdminUser.find(params[:id])
    end
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :nickname
      f.input :avatar
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
