require 'rails_helper'

RSpec.describe ApiConnector do
  it_behaves_like "Token generator"

  context "mock requests" do
    it "should return response with code 1000" do
      response = '{"code": "1000"}'

      body = double()
      allow(body).to receive(:body).and_return(response)

      api_connector = ApiConnector.new(username: "mock", password: "username")
      allow(api_connector).to receive(:faraday_request).with(url: "https://something", headers: {}, params: {}, ssl: nil).and_return(Faraday)

      allow(Faraday).to receive(:send).with(:get).and_return(body)

      response = api_connector.send(:request, url: "https://something", headers: {}, params: {}, method: :get)
      expect(response["code"]).to eq("1000")
    end
  end
end
