	module SingleAnswerCreate
		extend self

		def create_single_answer(answer_question_params:, user_answer:)
			answer_question = AnswerQuestion.create!(answer_question_params)
			user_answer.add_answer_question(answer_question)
		end
	end



