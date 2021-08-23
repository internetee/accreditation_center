require 'rails_helper'

RSpec.describe "PracticalContacts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/practical_contact/index"
      expect(response).to have_http_status(:success)
    end
  end

end
