class ChangeQuestionsTextEnToNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :questions, :text_en, false
  end
end
