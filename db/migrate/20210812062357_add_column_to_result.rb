class AddColumnToResult < ActiveRecord::Migration[6.1]
  def change
    add_reference :results, :quiz, null: false, foreign_key: true
  end
end
