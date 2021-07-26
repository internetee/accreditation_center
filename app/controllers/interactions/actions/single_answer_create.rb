module Actions
	class SingleAnswerCreate
		def initialize(answer_question_params, user_answer:)
			@answer_question_params = answer_question_params
			@user_answer = user_answer
		end

		def call
			create_single_answer
		end

		def create_single_answer
			@answer_question = AnswerQuestion.create!(@answer_question_params)
			@user_answer.add_answer_question(@answer_question)
		end
	end
end


