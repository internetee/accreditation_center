class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.integer :user_id
      t.datetime :start, null: false
      t.datetime :end, null: false
      t.boolean :passed, default: false, null: false
    end
  end
end
