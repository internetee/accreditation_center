module QuestionId
	extend self

	def generate_id_for_new_question(question_id:, user_answer:, quiz:)
		user = user_answer.user
		# quiz = Quiz.find(quiz_id)

		questions_ids = user.user_questions.where(quiz: quiz).pluck(:question_id)
		questions_of_current_quiz = Question.where(id: questions_ids)

		questions_of_current_quiz.each do |q|
			return q.id if !q.answered?(current_user: user, quiz: quiz)
		end

		return false

		# actual_questions = results.reject { |r| user_answer.question_ids.include? r.id && r.answered?(current_user: user, quiz: quiz) }
		#
		# return false if actual_questions.nil?
		#
		# return false if actual_questions.size < 1
		#
		# actual_questions.first.id
	end
end

