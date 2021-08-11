module GenerateQuestion
	extend self

	# def process(user)
	# 	quiz_theory = Quiz.create(title: "Theory", user: user)
	# end

	# def add_categories_to_theory_quiz
	# 	while quiz_theory.count < 5
	# 		offset = rand(Category.count)
 	# 		rand_record = Catetgory.offset(offset).first
	# 		quiz_theory.categories << rand_record unless quiz_theory.categories.include? rand_record
	# 	end
	# end


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