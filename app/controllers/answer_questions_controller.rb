class AnswerQuestionsController < ApplicationController
  before_action :set_user_answer, only: [:create]
  skip_before_action :verify_authenticity_token

  def create
    question = Question.find(params[:answer_question][:question_id])

    next_question_id = GenerateAnswer.process(answer_question_params, @user_answer)

    if next_question_id
      redirect_to quiz_question_path(quiz_id: answer_question_params[:quiz_id], id: next_question_id), notice: 'Question was answered.'
    else
      result = GenerateResult.process(user_answer: @user_answer, category_id: question.category_id)
      redirect_to category_result_path(category_id: question.category_id, id: result)
    end
  end

  private

  def answer_question_params
    params.require(:answer_question).permit(:quiz_id, :question_id, :answer_id, answer_id: [])
  end
end
