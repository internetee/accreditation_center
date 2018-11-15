class AddAnswersTextEt < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :text_et, :string, null: false
  end
end
