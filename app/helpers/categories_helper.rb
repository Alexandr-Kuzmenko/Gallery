module CategoriesHelper
  def own?(obj) 
    if current_admin_user
      return if current_admin_user == obj.categorized && obj.categorized_type == 'AdminUser'
    elsif current_user
      return if current_user == obj.categorized && obj.categorized_type == 'User'
    else
      false
    end
  end
end

