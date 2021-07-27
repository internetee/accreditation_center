class AnswerQuestion < ApplicationRecord
	belongs_to :quiz, optional: true
  belongs_to :question, optional: true
  belongs_to :answer, optional: true
  belongs_to :user_answer, optional: true
end
