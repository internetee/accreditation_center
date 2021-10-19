class AddColumnTitleEnForQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :title_en, :text
  end
end
