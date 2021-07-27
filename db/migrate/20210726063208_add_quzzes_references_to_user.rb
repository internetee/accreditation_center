class AddQuzzesReferencesToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :quizzes, :user, index: true
  end
end
