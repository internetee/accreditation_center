class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

  before_action :authenticate_user!
	before_action :set_user_answer

	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

	private

	def set_quiz
		if session[:quiz_id] == nil
      session[:quiz_id] = current_user.quizzes.first.id
    end
	end

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
