class RenameTestsUserIdToExamineeId < ActiveRecord::Migration[5.2]
  def change
    rename_column :tests, :user_id, :examinee_id
  end
end
