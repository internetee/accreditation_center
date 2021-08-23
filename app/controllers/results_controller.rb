class ResultsController < ApplicationController
  before_action :set_user_answer
  before_action :set_result
  before_action :restriction_for_other_candidates

  def index; end

  def show
    @output = generate_result_output
  end

  private

  def generate_result_output
    questions_ids = @user_answer.answer_questions.uniq.pluck(:question_id)
    questions = Question.where(id: questions_ids)
    questions
  end

  def restriction_for_other_candidates
      return if current_user.superadmin_role
      redirect_to root_path, notice: 'Authorization permitted' if current_user != @result.user
  end

  def set_result
    result = Result.find(params[:id])
    @result = ResultPresenter.new(result)
  end
end
