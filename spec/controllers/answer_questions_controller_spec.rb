require 'rails_helper'
require_relative "../support/devise"

RSpec.describe AnswerQuestionsController, type: :controller do
  let(:quiz) { create(:quiz) }
	let(:question) { create(:question) }
  let(:answer) { create(:answer, id: 1, title_ee: "Title", title_en: "Title") }
  let(:answer_t) { create(:answer, id: 2, title_ee: "Title", title_en: "Title") }
	let(:user_answer) { build(:user_answer) }
	let(:answer_question) { build(:answer_question, answer_id: 2, quiz_id: 6, question_id: 5, ) }
	let(:answer_question_t) { build(:answer_question, answer_id: 3) }

	login_user

	context 'actions' do
		it 'post create action' do
			post :create, params: { answer_question: {quiz_id: quiz.id, answer_id: answer.id , question_id: question.id } }

     	expect(response.content_type).to eq "text/html; charset=utf-8"
			expect(response).to have_http_status(:redirect)
		end
	end

	context 'interactions' do
		it 'multiple answers' do
			answer_question_params = {}

			user_answer.save

			answer_question_params[:answer_id] = [answer.id , answer_t.id]
			answer_question_params[:quiz_id] = quiz.id
			answer_question_params[:question_id] = question.id

			user_answer.answer_questions.empty?

			MultipleAnswerCreate.create_multiple_answer(answer_question_params: answer_question_params,
																															user_answer: user_answer)

			expect(user_answer.answer_questions.count).to eq(2)
		end
	end
end