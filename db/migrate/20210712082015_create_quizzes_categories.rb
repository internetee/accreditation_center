class CreateQuizzesCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :quizzes_categories do |t|
      t.references :quiz
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
