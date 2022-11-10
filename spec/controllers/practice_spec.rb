require 'rails_helper'
require_relative '../support/devise'

RSpec.describe PracticeController, type: :controller do
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
    it 'should be successfully index rendered' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
end
