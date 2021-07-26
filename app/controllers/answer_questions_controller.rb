# require_relative 'interactions/generators/question_id_generator.rb'
# require_relative 'interactions/actions/question_id_generator.rb'

class AnswerQuestionsController < ApplicationController
  before_action :set_user_answer, only: [:create]
  skip_before_action :verify_authenticity_token

  def create
    @answer_question_params = params[:answer_question]

    generators =  Actions::QuestionGeneratorIdCreate.new(question_id: @answer_question_params[:question_id],
                                                       user_answer: @user_answer)
    create_multiple_answer = Actions::MultipleAnswerCreate.new(answer_question_params: @answer_question_params,
                                                               user_answer: @user_answer)

    if @answer_question_params[:answer_id].kind_of?(Array)
      create_multiple_answer.call
    else
      create_single_answer
    end

    generated_question_id = generators.call

    if generated_question_id
      redirect_to quiz_question_path(quiz_id: @answer_question_params[:quiz_id], id: generated_question_id), notice: 'Question was answered.'
    else
      redirect_to root_path, notice: 'That is enough.'
    end
  end

  private

  def create_single_answer
    @answer_question = AnswerQuestion.create!(answer_question_params)
    @user_answer.add_answer_question(@answer_question)
  end

  def answer_question_params
    params.require(:answer_question).permit(:quiz_id, :question_id, :answer_id, answer_id: [])
  end
end
