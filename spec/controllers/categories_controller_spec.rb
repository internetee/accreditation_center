require 'rails_helper'
require_relative "../support/devise"

RSpec.describe CategoriesController, type: :controller do
	let(:quiz) { build(:quiz, id: 1) }

	let(:category) { build(:category) }
	let(:answer) { build(:answer) }
	let(:question) { build(:question, id: 1, category_id: category.id ) }

	let(:answer_question) { create(:answer_question, question: question, answer: answer) }
	let(:user_answer) { build(:user_answer, answer_questions: [answer_question]) }
	let(:user_questions) { build(:user_question, category: category, user: @user, question: question) }

	login_user

	context 'actions' do
		it 'get show action' do
			quiz.save
			category.save
			answer.save
			question.save

			user_answer.save
			user_questions.save

			get :show, params: { id: category.id, quiz_id: quiz.id }
																													 
			expect(response).to have_http_status(:ok)
			expect(response).to render_template("show")
		end
	end

	context 'interactions' do
		it 'generate result' do

		end
	end
end