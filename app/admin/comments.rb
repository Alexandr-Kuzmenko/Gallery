ActiveAdmin.register Comment do

  actions :all, except: [:new, :create]
  permit_params :text, :wallpaper_id
  menu priority: 5

  controller do
    before_action :load_comment, only: [:show, :edit, :update, :destroy]

    # def create
    #   comment = current_admin_user.comments.new(params.require(:comment).permit(:text, :wallpaper_id))
    #   comment.save ? redirect_to(admin_comments_path) : (render :edit)
    # end

    private

    def load_comment
      @comment = Comment.find(params[:id])
    end
  end

  index do
    selectable_column
    column :id
    column :commentable_type
    column :commentable_id
    column :wallpaper_id
    column :text
    column :created_at
    column :updated_at
    actions
  end

  form partial: 'form'

  # form do |f|
  #   f.inputs "Comment Edit" do
  #     f.input :text, label: 'Comment text:'
  #   end
  #   f.actions
  # end
end
