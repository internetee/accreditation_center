class AddQuestionsTextEt < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :text_et, :string, null: false
  end
end
