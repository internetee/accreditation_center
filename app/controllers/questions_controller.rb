class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update destroy ]
  before_action :set_user_answer

  # GET /questions or /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1 or /questions/1.json
  def show
    @question = Question.find(params[:id])
    @answers = Answer.where(question_id: params[:id])
    @answer_question = AnswerQuestion.new

    @category = @question.category
  end

  # GET /questions/new
  def new
    @question = Question.new
    @answer_question = AnswerQuestion.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions or /questions.json
  def create
    # @question = Question.new(question_params)
    @answer_question = AnswerQuestion.new(quiz_id: params[:quiz_id], answer_id: params[:answer_id], question_id: params[:question_id])

    respond_to do |format|
      if @answer_question.save
        format.html { redirect_to quiz_path(params[:quiz_id]), notice: "Question was successfully created." }
      else
        redirect_to root_path
      end
    end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: "Question was successfully updated." }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: "Question was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.fetch(:question, {})
    end
end
