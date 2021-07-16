class CategoriesController < ApplicationController
  def show
    @questions = Question.where(category_id: params[:id])

    category = Category.find(params[:id])
    @multiply = category.multiply
  end
end
