class AddColumnToAnswerQuestion < ActiveRecord::Migration[6.1]
  def change
    add_reference :answer_questions, :user_answer, index: true
  end
end
