class Result < ApplicationRecord
  belongs_to :user
  belongs_to :user_answer
  belongs_to :quiz

  def archived?
    created_at + 30.days < Time.now
  end
end
