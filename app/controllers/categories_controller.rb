class CategoriesController < ApplicationController
  before_action :set_user_answer

  def show
    @category = Category.find(params[:id])

    questions = Question.where(category_id: params[:id])

    return false if questions.size < 1

    @start_id = questions.first.id
  end
end
