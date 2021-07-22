require 'rails_helper'
require_relative "../support/devise"

RSpec.describe QuestionsController, type: :controller do
	login_user

	let(:quiz) { build(:quiz, id: 1) }
	let(:question) { create(:question, id: 1) }

	context 'actions' do
		it 'get show action' do
			get :show, params: { id: question.id, quiz_id: quiz.id }
																													 
			expect(response).to have_http_status(:ok)
			expect(response).to render_template("show")
		end
	end
end