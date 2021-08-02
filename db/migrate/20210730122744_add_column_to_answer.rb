class AddColumnToAnswer < ActiveRecord::Migration[6.1]
  def change
    add_reference :answers, :category, null: true, foreign_key: true
  end
end
