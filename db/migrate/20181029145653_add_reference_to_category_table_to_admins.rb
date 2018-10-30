class AddReferenceToCategoryTableToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_reference :categories, :categorized, polymorphic: true, index: true
  end
end
