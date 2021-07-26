require 'rails_helper'
require_relative "../support/devise"

RSpec.describe CategoriesController, type: :controller do
	let(:quiz) { build(:quiz, id: 1) }

	let(:category) { build(:category, id: 1) }

	let(:question) { build(:question, id: 1, category_id: category.id ) }

	login_user

	context 'actions' do
		it 'get show action' do
			quiz.save
			category.save
			question.save

			get :show, params: { id: category.id, quiz_id: quiz.id }
																													 
			expect(response).to have_http_status(:ok)
			expect(response).to render_template("show")
		end
	end
end