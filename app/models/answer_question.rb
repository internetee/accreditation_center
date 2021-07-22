class AnswerQuestion < ApplicationRecord
	belongs_to :quiz
  belongs_to :question
  belongs_to :answer

  # has_many :answer_questions, dependent: :destroy
end
