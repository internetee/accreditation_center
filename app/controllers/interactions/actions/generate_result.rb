module GenerateResult
	extend self

	def process(user_answer:, quiz_id:)
		result = Result.find_by(user: user_answer.user)
		return result.id if result.present?

		# @quiz = Quiz.find(quiz_id)

		# answers_ids = user_answer.answer_questions.pluck(:answer_id)
		# answers = Answer.where(id: answers_ids)

		# flag = check_result(answers)
		# result = create_result(flag: flag, user_answer: user_answer)
		# result
		result = new_some(user_answer: user_answer, quiz_id: quiz_id)
		result
	end

	def new_some(user_answer: , quiz_id:)

		quiz = Quiz.find(quiz_id)
		
		questions = user_answer.answer_questions.where(quiz_id: quiz_id).distinct.pluck(:question_id)

		questions_count = questions.count

		count = 0
		questions.each do |question|
			answer_ids = user_answer.answer_questions.where(question: question).pluck(:answer_id) 

			answers = Answer.where(id: @answer_ids)
			flag = true

			answers.each do |answer|
				flag = false unless answer.correct?
			end

			count += 1 if flag
		end

		per = (count.to_f / questions_count.to_f) * 100
		
		p "====================="
		p "count"
		p count
		p count.to_f
		p "================="
		p "questions_count"
		p questions_count
		p questions_count.to_f
		p "============="
		p "percenteges"
		p per
		p "==================="

		res = nil
		if per >= 70
			res = true
		else
			res = false
		end

		result = Result.create!(
			user_id: user_answer.user_id,
			user_answer: user_answer,
			quiz_id: quiz_id,
			result: res,
			percent: per
		)


		quiz.result = result
		quiz.save

		result
	end

	# def check_result(answers)
	# 	flag = true

	# 	answers.each do |answer|
	# 		flag = false unless answer.correct?
	# 	end

	# 	flag
	# end

	# def create_result(flag:, user_answer:)
	# 	result = Result.create!(
	# 		user_id: user_answer.user_id,
	# 		user_answer: user_answer,
	# 		quiz: @quiz,
	# 		result: flag
	# 	)

	# 	@quiz.result = result
	# 	@quiz.save

	# 	result
	# end
end