class RenameAnswersTextToTextEn < ActiveRecord::Migration[5.2]
  def change
    rename_column :answers, :text, :text_en
  end
end
