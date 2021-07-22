class AddReferenceToAnswerQuestion < ActiveRecord::Migration[6.1]
  def change
    add_reference :answers, :user_answer, index: true
  end
end
