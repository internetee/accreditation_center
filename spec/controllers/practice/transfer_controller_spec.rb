require 'rails_helper'
require_relative '../../support/devise'

RSpec.describe Practice::TransferController, type: :controller do
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

    practice_before.action_name = 'nameserver'
    practice_before.result = true

    practice_before.save
  end

  context 'render pages' do
    it 'should be successfully nameserver practice rendered if practice did not found' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'should be successfully nameserver practice rendered if practice found and result true' do
      practice.action_name = 'transfer'
      practice.result = true

      practice.save

      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'should be successfully nameserver practice rendered if practice found and result false' do
      practice.action_name = 'transfer'
      practice.result = false

      practice.save

      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'should create result and redirect to the index page' do
      @api_connector = double

      def complete_data
        {
          domain_name: 'test.com',
          api_connector: @api_connector,
          action: 'transfer',
          user: @user
        }
      end

      allow_any_instance_of(GenerateTransferCodeResult).to receive(:checking_data).with(complete_data).and_return(true)

      allow_any_instance_of(Practice::TransferController).to receive(:complete_data).and_return(complete_data)

      post :create
      expect(response).to have_http_status(:redirect)
    end
  end
end
