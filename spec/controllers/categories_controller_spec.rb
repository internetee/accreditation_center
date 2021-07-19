require 'rails_helper'
require_relative "../support/devise"

RSpec.describe CategoriesController, type: :controller do
	let(:category) { create(:category, id: 1) }
	login_user

	context 'actions' do
		it 'get show action' do
			get :show, params: { id: category.id }

			expect(response).to have_http_status(:ok)
		end
	end
end