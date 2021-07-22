require 'rails_helper'
require_relative "../support/devise"

RSpec.describe AnswerQuestionsController, type: :controller do
  let(:quiz) { build(:quiz, id: 1) }
	let(:question) { build(:question, id: 1) }
  let(:answer) { create(:answer, id: 1, title_ee: "Title", title_en: "Title") }

	login_user

	context 'actions' do
		it 'post create action' do
			post :create, params: { answer_question: {quiz_id: quiz.id, answer_id: answer.id , question_id: question.id } }

     	expect(response.content_type).to eq "text/html; charset=utf-8"
			expect(response).to have_http_status(:redirect)
		end
	end
end