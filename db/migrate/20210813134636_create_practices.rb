class CreatePractices < ActiveRecord::Migration[6.1]
  def change
    create_table :practices do |t|
      t.references :user, foreign_key: true
      t.boolean :result
      t.string :action_name

      t.timestamps
    end
  end
end
