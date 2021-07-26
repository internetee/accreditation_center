class CategoriesController < ApplicationController
  before_action :set_user_answer

  def show
    @category = Category.find(params[:id])
    @questions = Question.where(category_id: params[:id])
    
    redirect_to root_path if @questions.size < 1

    @start_id = QuestionId.generate_id_for_new_question(question_id: @questions.first.id, 
                                                        user_answer: @user_answer) 
    @questions_answered = questions_answered?(current_user.id)
  end

  private

  def questions_answered?(user_id)
    question_category_ids = @questions.pluck(:id)
    res = category_questions_answered(current_user, @category)
    
    res.count == question_category_ids.count
  end
end
