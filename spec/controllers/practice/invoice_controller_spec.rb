require 'rails_helper'
require_relative "../../support/devise"

RSpec.describe Practice::InvoiceController, type: :controller do
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
			practice_before.action_name = "delete"
			practice_before.result = true
		
			practice_before.save
		end

		it 'should be successfully nameserver practice rendered if practice did not found' do
			get :index
			expect(response).to have_http_status(:ok)
		end

		it 'should be successfully nameserver practice rendered if practice found and result true' do
			practice.action_name = "invoice"
			practice.result = true

			practice.save
			
			get :index
			expect(response).to have_http_status(:ok)
		end

		it 'should be successfully nameserver practice rendered if practice found and result false' do
			practice.action_name = "invoice"
			practice.result = false

			practice.save
			
			get :index
			expect(response).to have_http_status(:ok)
		end

		it 'should create result and redirect to the index page' do
			@api_connector = double()

  		def complete_data
				{
					api_connector: @api_connector, 
					action: "invoice", 
					user: @user,
				}
			end

			allow_any_instance_of(GenerateInvoiceResult).to receive(:checking_data).with(complete_data).and_return(true)

			allow_any_instance_of(Practice::InvoiceController).to receive(:complete_data).and_return(complete_data)
			
			post :create
			expect(response).to have_http_status(:redirect)
		end
	end
end