module Admin
  class QuestionsController < BaseController
    before_action :set_question, only: [:show, :edit, :update, :destroy]
    helper_method :categories

    def index
      @questions = Question.all
    end

    def show
    end

    def new
      @question = Question.new
      @question.answers.build
    end

    def edit
    end

    def create
      @question = Question.new(question_params)

      if @question.save
        redirect_to admin_question_url(@question), notice: 'Question was successfully created.'
      else
        render :new
      end
    end

    def update
      if @question.update(question_params)
        redirect_to admin_question_url(@question), notice: 'Question was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @question.destroy
      redirect_to admin_questions_url, notice: 'Question was successfully destroyed.'
    end

    private

    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:category_id,
                                       :text_en,
                                       :text_et,
                                       :comment,
                                       answers_attributes: [:id,
                                                            :_destroy,
                                                            :text_en,
                                                            :text_et,
                                                            :correct])
    end

    def categories
      Category.all
    end
  end
end
