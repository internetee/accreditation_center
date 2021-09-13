class CreatePracticeResults < ActiveRecord::Migration[6.1]
  def change
    create_table :practice_results do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :result

      t.timestamps
    end
  end
end
