require 'rails_helper'
require_relative "../support/devise"

RSpec.describe PracticeController, type: :controller do
	let(:result) { build(:result) }
	let(:category) { build(:category) }
	let(:another_user) { build(:user) }
	let(:user_answer) { build(:user_answer) }

	let(:answer_question) { build(:answer_question) }
	let(:question) { build(:question) }
	let(:answer) { build(:answer) }

	let(:practice) { build(:practice, user: @user) }

	context 'render pages' do
	# login happens by another user, which instance is @user
	login_user

		it 'should be successfully index rendered' do
			get :index
			expect(response).to have_http_status(:ok)
		end

		it 'should be successfully contact rendered if practice did not found' do
			get :contact
			expect(response).to have_http_status(:ok)
		end

		it 'should be successfully contact rendered if practice found and result true' do
			practice.action_name = "contact"
			practice.result = true

			practice.save
			
			get :contact
			expect(response).to have_http_status(:ok)
		end

		it 'should be successfully contact rendered if practice found and result false' do
			practice.action_name = "contact"
			practice.result = false

			practice.save
			
			get :contact
			expect(response).to have_http_status(:ok)
		end
	end
end