require 'rails_helper'
require_relative "../../support/devise"

RSpec.describe Practice::NameserverController, type: :controller do
	let(:result) { build(:result) }
	let(:category) { build(:category) }
	let(:another_user) { build(:user) }
	let(:user_answer) { build(:user_answer) }

	let(:answer_question) { build(:answer_question) }
	let(:question) { build(:question) }
	let(:answer) { build(:answer) }

	let(:practice) { build(:practice, user: @user) }
	let(:practice_before) { build(:practice, user: @user) }

	login_user

	before(:each) do
		hash = {
			"data" => {
				"domain" => {
					"transfer_code": "asddsfsf32",
					"name": "awesome.test"
				}
			}
		}

		allow(GenerateTransferCode).to receive(:process).and_return(hash)
	end

	context 'render pages' do
	before(:each) do
		cache = Rails.cache

		allow(cache).to receive(:read).with('domain_one').and_return('some.test')
		allow(cache).to receive(:read).with('domain_two').and_return('some2.test')
		allow(cache).to receive(:read).with('random_nameserver_one').and_return('some.test')
		allow(cache).to receive(:read).with('random_nameserver_two').and_return('some2.test')
		allow(cache).to receive(:read).with('random_nameserver').and_return('ns3.another.test')

		practice_before.action_name = "domain"
		practice_before.result = true
	
		practice_before.save
	end

		it 'should be successfully nameserver practice rendered if practice did not found' do
			get :index
			expect(response).to have_http_status(:ok)
		end

		it 'should be successfully nameserver practice rendered if practice found and result true' do
			practice.action_name = "nameserver"
			practice.result = true

			practice.save
			
			get :index
			expect(response).to have_http_status(:ok)
		end

		it 'should be successfully nameserver practice rendered if practice found and result false' do
			practice.action_name = "nameserver"
			practice.result = false

			practice.save
			
			get :index
			expect(response).to have_http_status(:ok)
		end
	end
end