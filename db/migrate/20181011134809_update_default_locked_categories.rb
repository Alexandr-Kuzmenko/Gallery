class UpdateDefaultLockedCategories < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :locked, :boolean
    add_column :categories, :locked, :boolean, default: false 
  end
end
