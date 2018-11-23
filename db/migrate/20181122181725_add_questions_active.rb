class AddQuestionsActive < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :active, :boolean, default: false, null: false
  end
end
