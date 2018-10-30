module CategoriesHelper
  def own?(obj) 
    if current_admin_user
      return if current_admin_user == obj.admin_user
    elsif current_user
      return if current_user == obj.user
    else
      false
    end
  end
end

