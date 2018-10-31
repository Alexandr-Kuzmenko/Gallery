class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :text, null: false
      t.references :wallpaper, foreign_key: true
      t.references :commentable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
