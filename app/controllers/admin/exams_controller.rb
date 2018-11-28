module Admin
  class ExamsController < BaseController
    def index
      @exams = Exam.all
    end

    def show
      @exam = Exam.find(params[:id])
    end
  end
end
