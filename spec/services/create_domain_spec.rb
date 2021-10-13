require 'rails_helper'


RSpec.describe CreateDomain do
  let(:user) { build(:user) }

  context "mock requests" do
		before(:each) do
			@token = "some-token"
			@header = { 'Authorization' => "Basic #{@token}" }
			@domain_name = "testing.domain"
      @api_connector = CreateDomain.new(username: user.username, password: user.password)

			@response_successful = {
        "code" => "1000",
        "message" => "Command completed successfully",
        "data" => {
            "domain" => {
                "name" => "#{@domain_name}",
                "transfer_code" => "42c959fad7690ac2adf530bb99a8fb8f"
            }
        }
      }
		end

		it "get info about domain" do
      payload = {
        "domain" => {
          "name" => "#{@domain_name}",
          "registrant" => "AA:VV",
          "period" => "1",
          "period_unit" => 'y'
        }
      }

			allow(@api_connector).to receive(:headers).and_return(@header)
			allow(@api_connector).to receive(:domain_endpoint).and_return("https://something/")
			allow(@api_connector).to receive(:payload).and_return(payload)
      allow(@api_connector).to receive(:request).with(url: @api_connector.domain_endpoint, 
                                                      headers: @api_connector.headers, 
                                                      method: :post, 
                                                      params: payload).and_return(@response_successful)

			response = @api_connector.create_domain
			expect(response["code"]).to eq("1000")
			expect(response["data"]["domain"]["name"]).to eq(@domain_name)
		end

		it "should return header" do
      token = Base64.urlsafe_encode64("#{ user.username}:#{user.password}")
      ENV['TEMPORARY_SECRET_KEY'] = "temporary-secret-key"

			api_connector = CreateDomain.new(username: user.username, password: user.password)
			expect(api_connector.headers).to eq({"Authorization"=>"Basic #{token}", "AccreditationToken"=>"temporary-secret-key"})
		end

    it "should return endpoint" do
			ENV['BASE_REPP_URL'] = 'https://api.website'
			ENV['CREATE_DOMAIN'] = '/repp/domains/'

			api_connector = CreateDomain.new(username: user.username, password: user.password)
			expect(api_connector.domain_endpoint).to eq("https://api.website/repp/domains/")
		end
	end
end