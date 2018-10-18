module CategoriesHelper
  def own?(obj) 
    current_user.id == obj.user_id if current_user.present?
  end
end

