module GenerateResult
	extend self

	def process(user_answer:, quiz_id:)
		result = Result.find_by(user: user_answer.user)
		return result.id if result.present?

		@quiz = Quiz.find(quiz_id)

		answers_ids = user_answer.answer_questions.pluck(:answer_id)
		answers = Answer.where(id: answers_ids)

		flag = check_result(answers)
		result = create_result(flag: flag, user_answer: user_answer)
		result
	end

	def check_result(answers)
		flag = true

		answers.each do |answer|
			flag = false unless answer.correct?
		end

		flag
	end

	def create_result(flag:, user_answer:)
		result = Result.create!(
			user_id: user_answer.user_id,
			user_answer: user_answer,
			quiz: @quiz,
			result: flag
		)

		@quiz.result = result
		@quiz.save

		result
	end
end