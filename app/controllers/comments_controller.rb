class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  after_action :record_changing, only: [:create]

  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    user = current_admin_user || current_user
    if user
      @wallpaper = Wallpaper.friendly.find(params[:wallpaper_id])
      # comment = user.comments.new(params.fetch(wallpaper_id: @wallpaper.id).permit(:text, :commentable_id, :commentable_type))
      comment = user.comments.new(comment_params)
      comment.wallpaper = @wallpaper
      if comment.save && verify_recaptcha(model: comment)
        @record_action = 'comments'
        redirect_to wallpaper_path(@wallpaper)
      end
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:wallpaper_id, :text, :commentable_id, :commentable_type)
  end
end
