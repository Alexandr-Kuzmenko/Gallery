ActiveAdmin.register Comment, as: 'User_Comment' do
  menu priority: 5
  permit_params :text, :wallpaper_id
  index do
    column :id
    column :commentable_id
    column :commentable_type
    column :text
    column :wallpaper_id
    column :created_at
    column :updated_at
    actions
  end

  controller do
    before_action :load_comment, only: [:show, :edit, :update, :destroy]
    before_action :load_parent_wallpaper, only: [:create, :destroy]

    def edit; end

    def create
      comment = current_admin_user.comments.new(comment_params)
      comment.wallpaper = @wallpaper
      if comment.save
        redirect_to admin_user_comments_path
      else
        render :new
      end
    end

    def update
      if @comment.update_attributes(comment_params)
        redirect_to admin_user_comments_path
      else
        render :edit
      end
    end

    def destroy
      @comment.destroy
      redirect_to admin_user_comments
    end

    private

    def load_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:text, :commentable_id, :commentable_type, :wallpaper_id)
    end

    def load_parent_wallpaper
      @wallpaper = Wallpaper.friendly.find(params[:wallpaper_id])
    end
  end
  form do |f|
    f.inputs "Comment Edit" do
      f.input :text, label: 'Comment text:'
    end
    f.actions
  end

end
