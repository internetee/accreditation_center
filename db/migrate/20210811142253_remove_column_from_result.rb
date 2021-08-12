class RemoveColumnFromResult < ActiveRecord::Migration[6.1]
  def change
    remove_column :results, :category_id, :references
  end
end
