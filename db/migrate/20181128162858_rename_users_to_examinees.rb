class RenameUsersToExaminees < ActiveRecord::Migration[5.2]
  def change
    rename_table :users, :examinees
  end
end
