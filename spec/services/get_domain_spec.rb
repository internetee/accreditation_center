require 'rails_helper'

RSpec.describe GetDomain do
  context "mock requests" do
		before(:each) do
			@token = "some-token"
			@header = { 'Authorization' => "Basic #{@token}" }
			@domain_name = "testing.domain"
      @api_connector = GetDomain.new(@token)

			@response_successful = {"code" => "1000", "data" => {
																								 	"domain" => {
																								 		"name" => "#{@domain_name}" 
																										 					 }
																														}
															}
		end

		it "get info about domain" do
			allow(@api_connector).to receive(:headers).and_return(@header)
			allow(@api_connector).to receive(:domain_endpoint).and_return("https://something/")
      allow(@api_connector).to receive(:request).with(url: @api_connector.domain_endpoint + @domain_name, headers: @api_connector.headers, method: :get, params: nil).and_return(@response_successful)

			response = @api_connector.get_domain(@domain_name)
			expect(response["code"]).to eq("1000")
			expect(response["data"]["domain"]["name"]).to eq(@domain_name)
		end

		it "should return header" do
			api_connector = GetDomain.new(@token)
			expect(api_connector.headers).to eq({"Authorization"=>"Basic some-token"})
		end

		# it "should return endpoint" do
		# 	api_connector = GetDomain.new(@token)

		# 	expect(api_connector.domain_endpoint).to eq(ENV['BASE_URL'] + ENV['GET_DOMAIN'] + '?name=')
		# end
	end
end