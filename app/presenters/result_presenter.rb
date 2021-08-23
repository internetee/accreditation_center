class ResultPresenter
	include ActionView::Helpers::TagHelper

	delegate_missing_to :@result

	def initialize(result)
		@result = result
	end

	def user_answer_questions(user_answer:, question:)
		answer_ids = user_answer.answer_questions.where(question: question).pluck(:answer_id)
		col = Answer.where(id: answer_ids)

		col.reduce(''.html_safe) { |x, answer| x << content_tag(:li, answer.title_en) }
	end

	def answer_result(user_answer:, question:)
		answer_ids = user_answer.answer_questions.where(question: question).pluck(:answer_id)
		col = Answer.where(id: answer_ids)

		flag = true

		col.each do |answer|
			flag = false unless answer.correct?
		end

		return content_tag(:span, "Corrent", class: "green") if flag
		content_tag(:span, "Failed", class: "answered")
	end
end
