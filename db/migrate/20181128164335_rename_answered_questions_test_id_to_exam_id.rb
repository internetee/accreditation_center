class RenameAnsweredQuestionsTestIdToExamId < ActiveRecord::Migration[5.2]
  def change
    rename_column :answered_questions, :test_id, :exam_id
  end
end
