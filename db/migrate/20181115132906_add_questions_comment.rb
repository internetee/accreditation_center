class AddQuestionsComment < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :comment, :text
  end
end
