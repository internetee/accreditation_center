class QuestionsController < ApplicationController
  before_action :set_user_answer

  def show
    @question = Question.find(params[:id])
    @category = @question.category
    
    question_ids = current_user.user_questions.where(category_id: @category.id).pluck(:question_id)
    @questions = Question.where(id: question_ids)
    
    @answers = Answer.where(question_id: params[:id])
    @answer_question = AnswerQuestion.new

    @total_answered_questions = total_answered_questions
    @total_category_questions = total_category_questions
  end

  private

  def total_answered_questions
    category_questions_answered(current_user, @category).count
  end

  def total_category_questions
    @category.questions.count
  end
end
