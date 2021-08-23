module GenerateQuestions
	extend self

	def process(user:, quiz:)
		@quiz_theory = quiz
		@user = user

		if TemplateSettingDisplay.count < 1
			generate_random_20_questions
		else
			generate_questions_by_template
		end
end

private

def generate_questions_by_template
	template = TemplateSettingDisplay.where(display: true)

	template.each do |category|
		generate_category_questions(category)
	end
end

def generate_category_questions(category)
	category_instance = Category.find(category.category_id)

	category.count.times do
		user_question = UserQuestion.new
		user_question.user = @user
		user_question.category = category_instance

		rand_record = add_unique_question(category_instance)

		user_question.question = rand_record
		user_question.quiz =  @quiz_theory
		user_question.save!
	end
end

def add_unique_question(category_instance)
	flag = true
	rand_record = nil
	while flag
		offset = rand(category_instance.questions.count)
    rand_record = category_instance.questions.offset(offset).first

		flag = false unless UserQuestion.find_by(user: @user, question_id: rand_record.id).present?
	end

	rand_record
end

def generate_random_20_questions
	20.times do
			offset = rand(Question.count)
			rand_record = Question.offset(offset).first

			user_question = UserQuestion.new
			user_question.user = @user
			user_question.question = rand_record
			user_question.category = rand_record.category
			user_question.quiz = @quiz_theory
			user_question.save
	end
end
end