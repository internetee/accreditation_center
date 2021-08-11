class QuizController < ApplicationController
  before_action :set_user_answer

  def show
    @quiz = Quiz.find(params[:id])
    # @categories = Category.where(quiz_id: @quiz.id)

    categories_ids = current_user.user_questions.pluck(:category_id)
    @categories = Category.where(id: categories_ids)

    session[:quiz_id] = @quiz.id
  end
end
