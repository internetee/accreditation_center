class ResultsController < ApplicationController
  before_action :set_user_answer
  before_action :set_result
  before_action :restriction_for_other_candidates

  def index; end

  def show
    @output = generate_result_output
    # @resulting = generate_user_categories_count
    # @resulting_count = generate_user_results_count
    
    # SendResult.process(user: current_user) # Test request
  end

  private

  # TODO:
  # Надо сделать таким образом: подсчитать, сколько всего категорий у пользователя. После чего выяснить, сколько категорий он уже прошел (это можно сделать, например, сравнить количество категорий и результатов). После чего нужно это дело загрузить в какой-нибудь хэш, к примеру, что указан ниже и отправить в какой-нибудь обработчик, в котором будет выполняться логика подсчета результатов и прочее говно. После чего результат будет направляться в интерактор SendResult, который будет отправлять результат в реестр, если конечн пользователь прошел аккредитацию, если нет - ничего отправляться не будет, а результат будет записан в локальную базу данных, где будет сказано, что аккредитация провалена.

  	# Example how should result params looks like
	# result_params: [
	# 	{
	# 		category_id: 3,
	# 		result: true
	# 	},
	# 	{
	# 		category_id: 5,
	# 		result: false
	# 	}
	# ]

  # def generate_user_categories(quiz_id)
  #   current_user.user_categories(quiz_id)
  # end

  # def compare_categories_and_results(quiz_id)
  #   current_user.user_categories(quiz_id).count == generate_user_results_count(quiz_id)
  # end

  # def generate_user_results_count(quiz_id)
  #   categories = genegenerate_user_categories(quiz_id)
  #   count = 0

  #   categories.each do |cat|
  #     count += cat.results.count
  #   end

  #   count
  # end

  def quiz_id
    c = Category.find(params[:category_id])
    c.quiz.id
  end

  def generate_result_output
    answers_ids = @user_answer.answer_questions.pluck(:answer_id)
    answers = Answer.where(id: answers_ids, category_id: params[:category_id]).includes(:question)
    answers
  end

  def restriction_for_other_candidates
      return if current_user.superadmin_role
      redirect_to root_path, notice: 'Authorization permitted' if current_user != @result.user
  end

  def set_result
    @result = Result.find(params[:id])
  end
end
