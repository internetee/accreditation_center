class AddQuestionsCategoryId < ActiveRecord::Migration[5.2]
  def change
    add_reference :questions, :category, foreign_key: true, null: false
  end
end
