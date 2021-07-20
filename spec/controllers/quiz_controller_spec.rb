require 'rails_helper'
require_relative "../support/devise"

RSpec.describe QuizController, type: :controller do
	let(:quiz) { create(:quiz, id: 1) }
	login_user

	context 'actions' do
		it 'get show action' do
			get :show, params: { id: quiz.id }

			expect(response).to have_http_status(:ok)
		end
	end
end