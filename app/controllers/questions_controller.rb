class QuestionsController < ApplicationController
  before_action :set_user_answer

  def show
    @question = Question.find(params[:id])
    @category = @question.category
    
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
