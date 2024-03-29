require 'rails_helper'
require_relative '../support/devise'

RSpec.describe QuestionsController, type: :controller do
  login_user

  let(:quiz) { create(:quiz, id: 1) }
  let(:question) { create(:question, id: 1) }

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
    it 'get show action' do
      get :show, params: { id: question.id, quiz_id: quiz.id }

      expect(response).to have_http_status(:ok)
      expect(response).to render_template('show')
    end
  end
end
