class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities, force: true do |t|
      t.string "user_type"
      t.integer "user_id"
      t.string "user_email"
      t.string "action"
      t.string "url_page"
      t.string "controller"

      t.timestamps
    end
  end
end
