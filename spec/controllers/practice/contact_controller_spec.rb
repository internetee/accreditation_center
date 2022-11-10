require 'rails_helper'
require_relative '../../support/devise'

RSpec.describe Practice::ContactController, type: :controller do
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

  context 'render pages' do
    it 'should be successfully contact practice rendered if practice did not found' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'should be successfully contact practice rendered if practice found and result true' do
      practice.action_name = 'contact'
      practice.result = true

      practice.save

      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'should be successfully contact practice rendered if practice found and result false' do
      practice.action_name = 'contact'
      practice.result = false

      practice.save

      get :index
      expect(response).to have_http_status(:ok)
    end
  end
end
