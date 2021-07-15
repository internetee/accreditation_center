class FixColumnTextInQuestion < ActiveRecord::Migration[6.1]
  def change
    rename_column :questions, :text, :title
  end
end
