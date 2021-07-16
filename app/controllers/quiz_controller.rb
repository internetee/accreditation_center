class QuizController < ApplicationController

  def show
    @quiz = Quiz.find(params[:id])
    @categories = Category.where(quiz_id: @quiz.id)
  end
end
