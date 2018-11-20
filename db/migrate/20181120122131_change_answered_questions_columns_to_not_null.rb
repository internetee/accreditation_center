class ChangeAnsweredQuestionsColumnsToNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :answered_questions, :test_id, false
    change_column_null :answered_questions, :question_id, false
    change_column_null :answered_questions, :answer_id, false
  end
end
