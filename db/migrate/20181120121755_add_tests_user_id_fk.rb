class AddTestsUserIdFk < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :tests, :users
    change_column_null :tests, :user_id, false
  end
end
