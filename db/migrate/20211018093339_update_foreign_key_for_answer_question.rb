class UpdateForeignKeyForAnswerQuestion < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :answer_questions, :quizzes
    add_foreign_key :answer_questions, :quizzes, on_delete: :cascade

    remove_foreign_key :quizzes, :results
    add_foreign_key :quizzes, :results, on_delete: :cascade

    remove_foreign_key :results, :quizzes
    add_foreign_key :results, :quizzes, on_delete: :cascade

    remove_foreign_key :user_questions, :quizzes
    add_foreign_key :user_questions, :quizzes, on_delete: :cascade
  end
end
