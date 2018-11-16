class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.belongs_to :question, foreign_key: true, null: false
      t.string :text, null: false
      t.boolean :correct, default: false, null: false
    end
  end
end
