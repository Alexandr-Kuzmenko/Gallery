class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  after_action :record_changing, only: [:create]
  before_action :load_comment, only: [:show, :edit, :update, :destroy]
  before_action :load_parent_wallpaper, only: [:create]

  def index
    @comments = Comment.all
  end

  def show; end

  def new
    @comment = Comment.new
  end

  def edit; end

  def create
    user = current_admin_user || current_user
    if user
      comment = @wallpaper.comments.new(comment_params.merge(commentable: user))
      if verify_recaptcha(model: comment) && comment.valid?
        comment.save
        @record_action = 'comments'
      else
        flash[:warning] = 'Comment has not been saved.'
      end
    redirection
    end
  end

  def update
    if current_admin_user
      if @comment.update_attributes(params.require(:comment).permit(:text, :wallpaper_id))
        redirect_to admin_comments_path
      end
    else
      render :show
    end
  end

  def destroy
    @comment.destroy
    redirection
  end

  private

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def redirection
    current_admin_user ? redirect_to(admin_comments_path) : redirect_to(wallpaper_path((@wallpaper)))
  end

  def comment_params
    params.require(:comment).permit(:text, :wallpaper_id)
  end

  def load_parent_wallpaper
    @wallpaper = Wallpaper.friendly.find(params[:wallpaper_id])
  end
end
