class CommentsController < ApplicationController
  skip_before_action :authenticate_user! || :authenticate_admin_user!, only: [:index, :show]

  def index
    @comments = Comment.all
  end

  def show
    load_comments
  end

  def new
    @comment = Comment.new
  end

  def edit
    load_comments
  end

  def create
    load_parent_wallpaper
    @comment = current_user.comments.new(comment_params)
    @comment.wallpaper = @wallpaper
    @comment.save ? redirect_to(wallpaper_path(@wallpaper)) : (render :new)
  end

  def update
    load_comments
    load_parent_wallpaper
    @comment.update_attributes(comment_params) ? redirect_to(wallpaper_path(@wallpaper)) : (render :edit)
  end

  def destroy
    load_comments
    load_parent_wallpaper
    @comment.destroy
    redirect_to(wallpaper_path(@wallpaper))
  end

  private

  def load_comments
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:wallpaper_id, :text, :user_id)
  end

  def load_parent_wallpaper
    @wallpaper = Wallpaper.find(params[:wallpaper_id])
  end
end
