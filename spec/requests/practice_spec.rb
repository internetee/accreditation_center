require 'rails_helper'

RSpec.describe "Practices", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/practice/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /contact" do
    it "returns http success" do
      get "/practice/contact"
      expect(response).to have_http_status(:success)
    end
  end

end
