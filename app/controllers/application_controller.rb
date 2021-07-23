class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

  before_action :authenticate_user!
	before_action :set_user_answer

	private

	def set_user_answer
		@user_answer = UserAnswer.find(session[:user_answer_id])
	rescue ActiveRecord::RecordNotFound
		@user_answer = UserAnswer.create(user: current_user)
		session[:user_answer_id] = @user_answer.id
	end

	def category_questions_answered(current_user, category)
		return [] if current_user.user_answers.last.nil?

		user_questions = current_user.user_answers.last.question_ids
    quest = Question.where(id: user_questions)

    quest.select { |q| q.category_id == category.id }
	end
end
