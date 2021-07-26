class AnswerQuestionsController < ApplicationController
  before_action :set_user_answer, only: [:create]
  skip_before_action :verify_authenticity_token

  def create
    generators =  Actions::QuestionIdGeneratorCreate.new(question_id: answer_question_params[:question_id],
                                                       user_answer: @user_answer)
    create_multiple_answer = Actions::MultipleAnswerCreate.new(answer_question_params: answer_question_params,
                                                               user_answer: @user_answer)
    create_single_answer = Actions::SingleAnswerCreate.new(answer_question_params,
                                                               user_answer: @user_answer)

    if answer_question_params[:answer_id].kind_of?(Array)
      create_multiple_answer.call
    else
      create_single_answer.call
    end

    generated_question_id = generators.call

    if generated_question_id
      redirect_to quiz_question_path(quiz_id: answer_question_params[:quiz_id], id: generated_question_id), notice: 'Question was answered.'
    else
      redirect_to root_path, notice: 'That is enough.'
    end
  end

  private

  def answer_question_params
    params.require(:answer_question).permit(:quiz_id, :question_id, :answer_id, answer_id: [])
  end
end
