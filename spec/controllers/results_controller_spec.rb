require 'rails_helper'
require_relative '../support/devise'

RSpec.describe ResultsController, type: :controller do
  let(:result) { build(:result) }
  let(:category) { build(:category) }
  let(:another_user) { build(:user) }
  let(:user_answer) { build(:user_answer) }

  let(:answer_question) { build(:answer_question) }
  let(:question) { build(:question) }
  let(:answer) { build(:answer) }

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

  context 'results prohibitted' do
    it 'only user can see his own results' do
      category.save
      result.user = @user
      result.save

      get :show, params: { id: result.id }
      expect(response).to have_http_status(:ok)
    end

    it 'another users cannot see other user results and will be redirected' do
      another_user.save

      category.save
      result.user = another_user
      result.save

      get :show, params: { id: result.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'administrator can looks users result' do
      another_user.save

      category.save
      result.user = another_user
      result.save

      @user.superadmin_role = true
      @user.save

      get :show, params: { id: result.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
