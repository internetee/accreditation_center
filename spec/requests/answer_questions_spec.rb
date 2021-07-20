require 'rails_helper'

RSpec.describe "AnswerQuestions", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/answer_questions/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/answer_questions/create"
      expect(response).to have_http_status(:success)
    end
  end

end
