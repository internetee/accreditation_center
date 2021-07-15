class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.string :title_en
      t.string :title_ee
      t.boolean :correct

      t.timestamps
    end
  end
end
