class AddUserAnswerReferenceToUser < ActiveRecord::Migration[6.1]
  def change
     add_reference :user_answers, :user, index: true
  end
end
