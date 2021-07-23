class CategoriesController < ApplicationController
  before_action :set_user_answer

  def show
    @category = Category.find(params[:id])

    @questions = Question.where(category_id: params[:id])
    @question_category_ids = @questions.pluck(:id)

    return false if @questions.size < 1

    @start_id = @questions.first.id

    @questions_answered = questions_answered?(current_user.id)
  end

  private

  def questions_answered?(user_id)
    res = category_questions_answered(current_user, @category)
    
    res.count == @question_category_ids.count
  end
end
