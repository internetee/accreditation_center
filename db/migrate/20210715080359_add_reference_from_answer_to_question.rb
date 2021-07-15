class AddReferenceFromAnswerToQuestion < ActiveRecord::Migration[6.1]
  def change
     add_reference :answers, :question, index: true
  end
end
