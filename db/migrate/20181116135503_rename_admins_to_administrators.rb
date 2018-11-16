class RenameAdminsToAdministrators < ActiveRecord::Migration[5.2]
  def change
    rename_table :admins, :administrators
  end
end
