class CategoriesController < ApplicationController
  before_action :set_user_answer

  def show
    @category = Category.find(params[:id])
    @questions = Question.where(category_id: params[:id])
    
    redirect_to root_path if @questions.size < 1

    @start_id = QuestionId.generate_id_for_new_question(question_id: @questions.first.id, 
                                                        user_answer: @user_answer)
    @result = GenerateResult.process(user_answer: @user_answer, category_id: params[:id])
  end
end
