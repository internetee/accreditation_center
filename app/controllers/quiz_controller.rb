class QuizController < ApplicationController
  before_action :set_user_answer

  def show
    @quiz = Quiz.find(params[:id])
    @categories = Category.where(quiz_id: @quiz.id)
  end
end
