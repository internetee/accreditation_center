class QuestionsController < ApplicationController
  before_action :set_user_answer

  def show
    @question = Question.find(params[:id])
    @answers = Answer.where(question_id: params[:id])
    @answer_question = AnswerQuestion.new

    @category = @question.category
  end
end
