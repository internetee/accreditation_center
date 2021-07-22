class CreateUserAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :user_answers do |t|

      t.timestamps
    end
  end
end
