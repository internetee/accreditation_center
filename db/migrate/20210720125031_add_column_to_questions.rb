class AddColumnToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_reference :questions, :user_answer, index: true
  end
end
