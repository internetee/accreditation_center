class CreateAnsweredQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :answered_questions do |t|
      t.belongs_to :test, foreign_key: true
      t.belongs_to :question, foreign_key: true
      t.belongs_to :answer, foreign_key: true
    end
  end
end
