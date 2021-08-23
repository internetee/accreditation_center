require 'rails_helper'
require_relative "../support/devise"

RSpec.describe QuizController, type: :controller do
	let(:result) { build(:result) }
	let(:category) { build(:category) }
	let(:quiz) { build(:quiz) }
	let(:another_user) { build(:user) }
	let(:user_answer) { build(:user_answer) }
	let(:user_questions) { build(:user_question) }

	let(:answer_question) { build(:answer_question) }
	let(:question) { build(:question) }
	let(:answer) { build(:answer) }

	login_user

	context 'render actions' do
		it "should render show action if there are start_id and quiz is theory" do
			question.save

			user_questions.category = category
			user_questions.question = question
			user_questions.quiz = quiz
			user_questions.user = @user
			user_questions.save
			
			user_answer.user = @user
			user_answer.save
			
			quiz.theory = true
			quiz.save

			allow(GenerateQuestions).to receive(:process).with(user: @user, quiz: quiz).and_return(quiz.id)

			get :show, params: { id: quiz.id }
			expect(response).to have_http_status(:redirect)
			expect(response).to redirect_to(quiz_question_path(quiz_id: quiz.id, id: question.id))
		end

		it 'should render if there is not any start ids and quiz has result' do
			@controller = QuizController.new

			question.save
			
			user_answer.user = @user
			user_answer.save
			
			quiz.theory = false
			quiz.result = result
			quiz.save

			result.quiz = quiz
			result.save

			allow(@controller).to receive(:generate_start_id).and_return(question.id)

			get :show, params: { id: quiz.id }
			expect(response).to have_http_status(:redirect)
			expect(response).to redirect_to(result_path(id: result.id))
		end
	end
end