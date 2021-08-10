class Result < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :user_answer

  def archived?
    created_at + 30.days < Time.now
  end
end
