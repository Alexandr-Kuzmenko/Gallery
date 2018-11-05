class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  after_action :record_changing, only: [:create]
  before_action :load_comment, only: [:show]
  before_action :load_parent_wallpaper, only: [:create]

  def index
    @comments = Comment.all
  end

  def show; end

  def new
    @comment = Comment.new
  end

  #def edit; end

  def create
    user = current_admin_user || current_user
    if user
      @comment = user.comments.new(comment_params)
      @comment.wallpaper = @wallpaper
      @record_action = "comments"
      if @comment.save
        redirect_to wallpaper_path(@wallpaper)
      end
    else
      render :new
    end
  end

  #def update
  #  if @comment.update_attributes(comment_params)
  #    redirect_to wallpaper_path(@wallpaper)
  #  else
  #    render :edit
  #  end
  #end

  #def destroy
  #  @comment.destroy
  #  redirect_to wallpaper_path(@wallpaper)
  #end

  private

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:wallpaper_id, :text, :commentable_id, :commentable_type)
  end

  def load_parent_wallpaper
    @wallpaper = Wallpaper.find(params[:wallpaper_id])
  end
end
