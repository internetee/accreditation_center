class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.belongs_to :user, null: false, foreign_key: true, null: true
      t.belongs_to :category, null: false, foreign_key: true, null: true
      t.belongs_to :user_answer, null: false, foreign_key: true, null: true
      t.boolean :result

      t.timestamps
    end
  end
end
