module GenerateResult
	extend self

	def process(user_answer:, category_id:)
		result = Result.find_by(category_id: category_id)
		return result.id if result.present?

		answers_ids = user_answer.answer_questions.pluck(:answer_id)
		answers = Answer.where(id: answers_ids, category_id: category_id)

		flag = check_result(answers)
		result = create_result(flag: flag, user_answer: user_answer, category_id: category_id)
		result
	end

	def check_result(answers)
		flag = true

		answers.each do |answer|
			flag = false unless answer.correct?
		end

		flag
	end

	def create_result(flag:, user_answer:, category_id:)
		result = Result.create(
			user_id: user_answer.user_id,
			category_id: category_id,
			user_answer: user_answer,
			result: flag
		)

		result
	end
end