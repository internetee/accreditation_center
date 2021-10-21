module GenerateResult
	extend self

	def process(user_answer:, quiz_id:)
		@quiz = Quiz.find(quiz_id)

		result = Result.find_by(user: user_answer.user, quiz: @quiz)
		return result.id if result.present?

		result = result_generator(user_answer: user_answer, quiz_id: quiz_id)
		result
	end

	def result_generator(user_answer: , quiz_id:)
		questions = user_answer.answer_questions.where(quiz: @quiz).distinct.pluck(:question_id)
		questions_count = questions.count

		
		correctly_answers_count = correctly_answer_iterator(questions: questions, user_answer: user_answer)
		percent = percent_counter(correctly_answers_count: correctly_answers_count, questions_count: questions_count)
		result = create_result(percent: percent, quiz: @quiz, user_answer: user_answer)

		result
	end

	def correctly_answer_iterator(questions:, user_answer:)
			correctly_answers_count = 0

			questions.each do |question|
				answer_ids = user_answer.answer_questions.where(quiz: @quiz, question: question).pluck(:answer_id)

				answers = Answer.where(id: answer_ids)
				flag = true

				answers.each do |answer|
					flag = false unless answer.correct?
				end

				correctly_answers_count += 1 if flag
			end
		correctly_answers_count
	end

	def percent_counter(correctly_answers_count:, questions_count:)
		percent = (correctly_answers_count.to_f / questions_count.to_f) * 100

		percent.round(2)
	end

	def create_result(percent:, quiz:, user_answer:)
		res = nil
		
		if percent >= 70
			res = true

			user = User.find(user_answer.user_id)
			SendResult.process(user: user)
		else
			res = false
		end

		result = Result.create!(
			user_id: user_answer.user_id,
			user_answer: user_answer,
			quiz: quiz,
			result: res,
			percent: percent
		)


		quiz.result = result
		quiz.save!

		result
	end
end