require 'rails_helper'
require_relative "../support/devise"

RSpec.describe QuestionsController, type: :controller do
	login_user

	context 'actions' do
		it 'get index action' do
			get :index
			expect(response).to have_http_status(:ok)
		end
	end
end