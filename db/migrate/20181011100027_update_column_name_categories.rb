class UpdateColumnNameCategories < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :Name, :string
    add_column :categories, :name, :string
  end
end
