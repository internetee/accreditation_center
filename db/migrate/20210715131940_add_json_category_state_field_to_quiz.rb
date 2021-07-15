class AddJsonCategoryStateFieldToQuiz < ActiveRecord::Migration[6.1]
  def change
    add_column :quizzes, :json_category_state, :jsonb, if_not_exists: true
    add_index :quizzes, :json_category_state, using: :gin, if_not_exists: true
  end
end
