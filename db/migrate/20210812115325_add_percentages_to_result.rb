class AddPercentagesToResult < ActiveRecord::Migration[6.1]
  def change
    add_column :results, :percent, :decimal
  end
end
