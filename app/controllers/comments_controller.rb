class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :load_comment, only: [:show, :edit, :update, :destroy]
  before_action :load_parent_wallpaper, only: [:create, :update, :destroy]

  def index
    @comments = Comment.all
  end

  def show; end

  def new
    @comment = Comment.new
  end

  def edit; end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.wallpaper = @wallpaper
    if @comment.save
      redirect_to wallpaper_path(@wallpaper)
    else
      render :new
    end
  end

  def update
    if @comment.update_attributes(comment_params)
      redirect_to wallpaper_path(@wallpaper)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to wallpaper_path(@wallpaper)
  end

  private

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:wallpaper_id, :text, :user_id)
  end

  def load_parent_wallpaper
    @wallpaper = Wallpaper.find(params[:wallpaper_id])
  end
end
