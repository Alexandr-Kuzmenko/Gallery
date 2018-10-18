class CommentsController < ApplicationController
  before_action :authenticate_user!

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
    @wallpaper = Wallpaper.find(params[:wallpaper_id])
    @comment = current_user.comments.new(comment_params)
    @comment.wallpaper = @wallpaper
    redirect_to wallpaper_path(@wallpaper) if @comment.save!
  end

  def update
    load_comments
    if @comment.update_attributes(comment_params)
      redirect_to comments_path
    else
      render :edit
    end
  end

  def destroy
    @comment = load_comments
    @comment.destroy
    redirect_to comments_path
  end

  private

  def load_comments
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:wallpaper_id, :text, :user_id)
  end
end
