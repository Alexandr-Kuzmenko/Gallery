module CategoriesHelper
  def own?(obj)
    current_user.id == obj.user_id
  end
end

