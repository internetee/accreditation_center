module QuestionId
	extend self

	def generate_id_for_new_question(question_id:, user_answer:)
		question = Question.find(question_id)

		user = user_answer.user
		# results = Question.where(category_id: category.id)
		questions_ids = user.user_questions.pluck(:question_id)
    results = Question.where(id: questions_ids)

		actual_questions = results.reject { |r| user_answer.question_ids.include? r.id }

		return false if actual_questions.nil?

		return false if actual_questions.size < 1

		actual_questions.first.id
	end
end

