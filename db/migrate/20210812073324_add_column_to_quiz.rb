class AddColumnToQuiz < ActiveRecord::Migration[6.1]
  def change
    add_reference :quizzes, :result, foreign_key: true
    add_column :quizzes, :theory, :boolean
  end
end
