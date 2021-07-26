module Actions
	class MultipleAnswerCreate
		def initialize(answer_question_params:, user_answer:)
			@answer_ids = answer_question_params[:answer_id]
			@quiz_id = answer_question_params[:quiz_id]
			@question_id = answer_question_params[:question_id]
			@user_answer = user_answer
		end

		def call
			create_multiple_answer
		end

		def create_multiple_answer
			@answer_ids.each do |item|
					next if item == ""

					@answer_question = AnswerQuestion.create!({
						quiz_id: @quiz_id,
						question_id: @question_id,
						answer_id: item
					})

					@user_answer.add_answer_question(@answer_question)
				end
		end
	end
end



