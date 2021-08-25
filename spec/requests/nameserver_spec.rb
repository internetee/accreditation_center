require 'rails_helper'

RSpec.describe "Nameservers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/nameserver/index"
      expect(response).to have_http_status(:success)
    end
  end

end
