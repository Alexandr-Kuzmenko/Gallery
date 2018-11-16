class LikesController < ApplicationController
  before_action :authenticate_user!
  after_action :record_changing, only: [:new]

  def new
    @wallpaper = Wallpaper.friendly.find(params[:wallpaper_id])
    check_like ? nail_like : put_like
    current_admin_user ? redirect_to(admin_wallpaper_path(@wallpaper)) : redirect_to(wallpaper_path(@wallpaper))
  end

  private

  # methods for the button: "like"

  def put_like
    @like = current_user.likes.create(wallpaper: @wallpaper)
    @record_action = 'likes'
    #UserMailer.with(user: current_user).greetings_email.deliver_now
  end

  def nail_like
    @like.destroy
    @record_action = 'dislikes'
  end

  def check_like
    @like = current_user.likes.find_by wallpaper: @wallpaper
  end

  # end of methods for the button: "like"
end

# def after_sign_in_path_for(_resource)
#   respond_to do |format|
#     if current_user
#       # Tell the UserMailer to send a welcome email after save
#       UserMailer.with(user: current_user).greetings_email.deliver_now
#
#       format.html { redirect_to(users_path, notice: 'User entered site.') }
#     end
#     #  format.json { render json: @user, status: :signed in, location: @user }
#     #else
#     #  format.html { render action: 'new' }
#     #  format.json { render json: @user.errors, status: :unprocessable_entity }
#   end
# end
