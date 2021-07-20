class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

  before_action :authenticate_user!
	before_action :set_user_answer

	private

	def set_user_answer
		@user_answer = UserAnswer.find(session[:user_answer_id])
	rescue ActiveRecord::RecordNotFound
		@user_answer = UserAnswer.create
		session[:user_answer_id] = @user_answer.id
	end
end
