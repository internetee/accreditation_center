class AddTypeColumnToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :question_type, :integer
  end
end
