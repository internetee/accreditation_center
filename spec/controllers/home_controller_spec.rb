require 'rails_helper'
require_relative '../support/devise'

RSpec.describe HomeController, type: :controller do
  login_user

  before(:each) do
    hash = {
      'data' => {
        'domain' => {
          "transfer_code": 'asddsfsf32',
          "name": 'awesome.test'
        }
      }
    }

    structed_response = Struct.new(:success?, :payload, :errors)
                     .new(true, hash, nil)

    allow_any_instance_of(PracticeServices::GenerateTransferCodeService).to receive(:call).and_return(structed_response)
  end

  context 'actions' do
    it 'get index action' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
end
