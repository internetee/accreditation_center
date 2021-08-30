require 'rails_helper'
require_relative "../../support/devise"

RSpec.describe Practice::DomainsController, type: :controller do
	let(:result) { build(:result) }
	let(:category) { build(:category) }
	let(:another_user) { build(:user) }
	let(:user_answer) { build(:user_answer) }

	let(:answer_question) { build(:answer_question) }
	let(:question) { build(:question) }
	let(:answer) { build(:answer) }

	let(:practice) { build(:practice, user: @user) }

	context 'render pages' do
	login_user

	before(:each) do
		cache = Rails.cache

		allow(cache).to receive(:read).with('domain_one').and_return('some.test')
		allow(cache).to receive(:read).with('domain_two').and_return('some2.test')
		allow(cache).to receive(:read).with('random_nameserver').and_return('ns3.another.test')
	end

		it 'should be successfully domain practice rendered if practice did not found' do
			get :index
			expect(response).to have_http_status(:ok)
		end

		it 'should be successfully domain practice rendered if practice found and result true' do
			practice.action_name = "domain"
			practice.result = true

			practice.save
			
			get :index
			expect(response).to have_http_status(:ok)
		end

		it 'should be successfully domain practice rendered if practice found and result false' do
			practice.action_name = "domain"
			practice.result = false

			practice.save
			
			get :index
			expect(response).to have_http_status(:ok)
		end
	end
end