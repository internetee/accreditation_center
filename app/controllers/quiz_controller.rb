class QuizController < ApplicationController
  before_action :set_user_answer
  before_action :set_quiz
  before_action :start_generate_questions, only: [:show]

  def prepare
  end

  def show
    @start_id = generate_start_id

    if @start_id && @quiz.theory
      redirect_to quiz_question_path(quiz_id: @quiz.id, id: @start_id)
    else
      res = @quiz.result
      redirect_to result_path(id: res.id)
    end
  end

  private

  def generate_start_id
    questions_ids = current_user.user_questions.pluck(:question_id)
    @questions = Question.where(id: questions_ids)
  
    QuestionId.generate_id_for_new_question(question_id: @questions.first.id,
                                                        user_answer: @user_answer)
  end

  def set_quiz
    @quiz = Quiz.find(params[:id])
  end

  def start_generate_questions
    GenerateQuestions.process(user: current_user, quiz: @quiz) if current_user.user_questions.empty? && @quiz.theory
  end
end
