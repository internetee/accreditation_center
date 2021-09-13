# class ResultStatusPresenter
# 	include ActionView::Helpers::TagHelper

# 	delegate_missing_to :@quiz

# 	def initialize(quiz)
# 		@quiz = quiz
# 	end

#   def i_dont_know_about
#     if @quiz.theory
#       if quiz.result
									
#         if quiz.result.result
#           <span class='green'>Success</span>
#         else
#           <span class='answered'>Failed</span>
#         end

#       else
#         Waiting for chellenge
#       end

#       else
#       @practice = PracticeResult.find_by(user: current_user)
#       unless @practice.nil?
#         @practice.result
#       end
#         Waiting for chellenge
#     end
#     end
#   end

#   def generate_tag(flag)
#     return content_tag(:span, "Corrent", class: "green") if flag
# 	  content_tag(:span, "Failed", class: "answered")
#   end
















# 	# def user_answer_questions(user_answer:, question:)
# 	# 	answer_ids = user_answer.answer_questions.where(question: question).pluck(:answer_id)
# 	# 	col = Answer.where(id: answer_ids)

# 	# 	col.reduce(''.html_safe) { |x, answer| x << content_tag(:li, answer.title_en) }
# 	# end

# 	# def answer_result(user_answer:, question:)
# 	# 	answer_ids = user_answer.answer_questions.where(question: question).pluck(:answer_id)
# 	# 	col = Answer.where(id: answer_ids)

# 	# 	flag = true

# 	# 	col.each do |answer|
# 	# 		flag = false unless answer.correct?
# 	# 	end

# 	# 	return content_tag(:span, "Corrent", class: "green") if flag
# 	# 	content_tag(:span, "Failed", class: "answered")
# 	# end
# end
