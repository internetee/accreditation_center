class CreateTemplateSettingDisplays < ActiveRecord::Migration[6.1]
  def change
    create_table :template_setting_displays do |t|
      t.references :category, foreign_key: true, unique: true
      t.boolean :display
      t.integer :count

      t.timestamps
    end
  end
end
