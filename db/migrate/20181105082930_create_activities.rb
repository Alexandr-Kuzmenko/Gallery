class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities, force: true do |t|
      t.references :user, foreign_key: true
      #t.integer "action", default: 0
      t.string :action_type
      t.string :url_page

      t.timestamps
    end
  end
end
