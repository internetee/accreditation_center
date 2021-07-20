class CategoriesController < ApplicationController
  before_action :set_user_answer

  def show
    @category = Category.find(params[:id])

    questions = Question.where(category_id: params[:id])

    @start_id = questions.first.id
  end

  private

  def random_question_id
  end
end
