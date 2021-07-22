class Question < ApplicationRecord
  belongs_to :category
  has_many :answers

  has_many :answer_questions, dependent: :destroy

  validates :title, presence: true

  enum question_type: { single_choice: 0, multiple_choice: 1, long_answer: 2 }
end
