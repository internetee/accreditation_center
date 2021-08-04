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
    answers_ids = @user_answer.answer_questions.pluck(:answer_id)
    answers = Answer.where(id: answers_ids, category_id: params[:category_id]).includes(:question)

    # @resulting = send_results # Test request
    @resulting = nil
    answers
  end

  # TODO: This is test get request, but follow to logic it needs to change to post and also move mock user password into
  # credintional or into env file or session and so on

  def send_results
    result = Results.new(username: "oleghasjanov", password: "123456")
    result.push_results
  end

  # =====================

  def restriction_for_other_candidates
      return if current_user.superadmin_role
      redirect_to root_path, notice: 'Authorization permitted' if current_user != @result.user
  end

  def set_result
    @result = Result.find(params[:id])
  end
end
