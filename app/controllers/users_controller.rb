class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, only: [:index, :edit, :update, :destroy]

  def index; end

  def edit; end

  def update
    if @user.update_attributes(params.require(:user).permit(:nickname, :avatar, :encrypted_password, :password_confirmation))
      current_admin_user ? redirect_to(admin_user_users_path) : redirect_to(users_path)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def load_user
    @user = User.includes(:subscriptions).find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:nickname, :avatar)
  end
end
