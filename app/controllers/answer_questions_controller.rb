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
        redirect_to quiz_question_path(quiz_id: a[:quiz_id], id: question_id), notice: 'Question was answered.'
      else
        redirect_to root_path, notice: 'That is enough.'
      end
    else
      redirect_to root_path, notice: 'FAIL'
    end
  end

  private

  def answer_question_params
    params.require(:answer_question).permit(:quiz_id, :answer_id, :question_id)
  end

  def generate_id_for_new_question
    question = Question.find(@answer_question.question_id)
    category = question.category

    results = Question.where(category_id: category.id)

    actual_questions = results.reject { |r| @user_answer.question_ids.include? r.id }

    return false if actual_questions.nil?

    return false if actual_questions.size < 1

    actual_questions.sample.id
  end
end
