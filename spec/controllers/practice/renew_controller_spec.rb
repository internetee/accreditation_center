require 'rails_helper'
require_relative "../../support/devise"

RSpec.describe Practice::RenewController, type: :controller do
	let(:result) { build(:result) }
	let(:category) { build(:category) }
	let(:another_user) { build(:user) }
	let(:user_answer) { build(:user_answer) }

	let(:answer_question) { build(:answer_question) }
	let(:question) { build(:question) }
	let(:answer) { build(:answer) }

	let(:practice) { build(:practice, user: @user) }

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

		@api_connector = double()

		def complete_data
			{
				domain_one: "test.com",
				domain_two: "awesome.com",
				domain_one_expire_date: "2022-09-02T00:00:00.000+03:00",
				domain_two_expire_date: "2022-09-02T00:00:00.000+03:00",
				api_connector: @api_connector, 
				action: "change_registrant_email", 
				user: @user,
			}
		end

		allow_any_instance_of(GenerateRenewResult).to receive(:checking_data).with(complete_data).and_return(true)
		allow_any_instance_of(GetDomainExpireDate).to receive(:process).with(domain: "test.com", api_connector: @api_connector).and_return(true)
		allow_any_instance_of(GetDomainExpireDate).to receive(:process).with(domain: "awesome.com", api_connector: @api_connector).and_return(true)

		allow_any_instance_of(Practice::RenewController).to receive(:complete_data).and_return(complete_data)
		allow_any_instance_of(Practice::RenewController).to receive(:get_domains_expire_dates).and_return(true)
		
	end

	context 'render pages' do
		it 'should be successfully renew practice rendered if practice did not found' do
			get :index
			expect(response).to have_http_status(:ok)
		end

		it 'should be successfully renew practice rendered if practice found and result true' do
			practice.action_name = "change_registrant_email"
			practice.result = true

			practice.save
			
			get :index
			expect(response).to have_http_status(:ok)
		end

		it 'should be successfully renew practice rendered if practice found and result false' do
			practice.action_name = "change_registrant_email"
			practice.result = false

			practice.save
			
			get :index
			expect(response).to have_http_status(:ok)
		end

		it 'should create result and redirect to the index page' do

			post :create
			expect(response).to have_http_status(:redirect)
		end
	end
end