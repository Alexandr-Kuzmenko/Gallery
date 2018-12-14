ActiveAdmin.register User do

  menu priority: 3

  controller do
    before_action :load_user, only: [:show, :edit, :update, :destroy]

    private

    def load_user
      @user = User.friendly.find(params[:id])
    end
  end

  index do
    selectable_column
    column :email
    column :id
    column :nickname
    column :provider
    actions
  end
end
