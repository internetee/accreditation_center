class QuestionsController < ApplicationController
  before_action :set_user_answer

  def show
    @question = Question.find(params[:id])
    @category = @question.category
    
    question_ids = current_user.user_questions.pluck(:question_id)
    @questions = Question.where(id: question_ids)
    
    @answers = Answer.where(question_id: params[:id])
    @answer_question = AnswerQuestion.new

    @total_answered_questions = total_answered_questions
    @total_category_questions = total_category_questions
  end

  private

  def total_answered_questions
    user_answer = current_user.user_answers.last
    uniques = user_answer.answer_questions.distinct.pluck(:question_id)
    uniques.count
  end

  def total_category_questions
    current_user.user_questions.count
  end
end
