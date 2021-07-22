class CreateAnswerQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :answer_questions do |t|
      t.belongs_to :quiz, foreign_key: true
      t.belongs_to :question, foreign_key: true
      t.belongs_to :answer, foreign_key: true
      t.timestamps
    end
  end
end
