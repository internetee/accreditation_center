class RenameTestsToExams < ActiveRecord::Migration[5.2]
  def change
    rename_table :tests, :exams
  end
end
