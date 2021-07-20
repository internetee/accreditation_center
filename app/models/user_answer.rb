class UserAnswer < ApplicationRecord
	has_many :answer_questions, dependent: :destroy
	has_many :questions, dependent: :destroy

	def add_answer_question(answer_question)
		self.answer_questions << answer_question

		q = Question.find(answer_question.question_id)

		self.questions << q
	end
end
