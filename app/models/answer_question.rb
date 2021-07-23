class AnswerQuestion < ApplicationRecord
	belongs_to :quiz, optional: true
  belongs_to :question, optional: true
  belongs_to :answer, optional: true

  # has_many :answer_questions, dependent: :destroy
end
