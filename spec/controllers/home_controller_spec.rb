require 'rails_helper'
require_relative "../support/devise"

RSpec.describe HomeController, type: :controller do
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

	context 'actions' do
		it 'get index action' do
			get :index
			expect(response).to have_http_status(:ok)
		end
	end
end