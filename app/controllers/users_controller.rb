class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, only: [:index, :edit, :update, :destroy]
  before_action :subscriptions_list, only: [:index]

  def index; end

  #def show; end

  #def new
  #  @user = User.new
  #end

  def edit; end

  #def create
  #  @category = User.new(user_params)
  #end

  def update
    if @user.update_attributes(user_params)
      redirection
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def redirection
    current_admin_user ? redirect_to(admin_user_users_path) : redirect_to(users_path)
  end

  def load_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:nickname, :avatar)
  end

  def subscriptions_list
    @subscriptions = current_user.subscriptions
  end
end
