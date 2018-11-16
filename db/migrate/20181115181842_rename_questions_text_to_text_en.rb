class RenameQuestionsTextToTextEn < ActiveRecord::Migration[5.2]
  def change
    rename_column :questions, :text, :text_en
  end
end
