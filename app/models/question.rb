class Question < ApplicationRecord
  belongs_to :category
  has_many :answers

  has_many :answer_questions, dependent: :destroy

  validates :title, presence: true

  enum question_type: { "single choice": 0, "multiple choice": 1, "long answer": 2 }
end
