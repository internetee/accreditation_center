class AnswerQuestionsController < ApplicationController
  before_action :set_user_answer, only: [:create]
  skip_before_action :verify_authenticity_token

  def create
    a = params[:answer_question]
    @answer_question = AnswerQuestion.new(answer_question_params)

    if @answer_question.save
      @user_answer.add_answer_question(@answer_question)
      question_id = generate_id_for_new_question

      if question_id
        redirect_to quiz_question_path(quiz_id: a[:quiz_id], id: generate_id_for_new_question), notice: 'Question was answered.'
      else
        redirect_to root_path, notice: 'That is enough.'
      end
    else
      redirect_to root_path, notice: 'FAIL'
    end

  end

  private

  # Only allow a list of trusted parameters through.
  def answer_question_params
    params.require(:answer_question).permit(:quiz_id, :answer_id, :question_id)
  end

  def generate_id_for_new_question
    question = Question.find(@answer_question.question_id)
    category = question.category

    result = Question.where(category_id: category.id).where(user_answer_id: nil).first
    return false if result.nil?

    result.id  
  end
end
