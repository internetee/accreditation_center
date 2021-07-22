class RemoveColumnFromQuestions < ActiveRecord::Migration[6.1]
  def change
    remove_column :questions, :user_answer_id
  end
end
