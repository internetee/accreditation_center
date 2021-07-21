class UserAnswer < ApplicationRecord
	has_many :answer_questions, dependent: :destroy
	has_many :questions, through: :answer_questions
	has_many :answers, through: :answer_question

	belongs_to :user

	def add_answer_question(answer_question)
		self.answer_questions << answer_question
	end
end
