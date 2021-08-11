module GenerateQuestion
	extend self

	def process(user)
		quiz_theory = Quiz.create(title: "Theory", user: user)

		# while user.user_questions.count < 20
		# 		offset = rand(Question.count)
		# 		rand_record = Question.offset(offset).first

		# 		user_question = UserQuestion.new
		# 		user_question.user = user
		# 		user_question.question = rand_record
		# 		user_question.category = rand_record.category
		# 		user_question.quiz = quiz_theory
		# 		user_question.save
		# end

		20.times do
				offset = rand(Question.count)
				rand_record = Question.offset(offset).first

				user_question = UserQuestion.new
				user_question.user = user
				user_question.question = rand_record
				user_question.category = rand_record.category
				user_question.quiz = quiz_theory
				user_question.save
		end
	end

end