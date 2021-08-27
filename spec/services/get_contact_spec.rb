require 'rails_helper'

RSpec.describe GetDomain do
  context "mock requests" do
		before(:each) do
			@token = "some-token"
			@header = { 'Authorization' => "Basic #{@token}" }
			@contact_id = "AABB:1122"
      @api_connector = GetContact.new(@token)
			@contact_name = "John"

			@response_successful = {"code" => "1000", "contact" => { "name" => "#{@contact_name}" } }
		end

		it "get info about domain" do
			allow(@api_connector).to receive(:headers).and_return(@header)
			allow(@api_connector).to receive(:contact_endpoint).and_return("https://something/")
      allow(@api_connector).to receive(:request).with(url: @api_connector.contact_endpoint + @contact_id, headers: @api_connector.headers, method: :get, params: nil).and_return(@response_successful)

			response = @api_connector.get_contact(@contact_id)
			expect(response["code"]).to eq("1000")
			expect(response["contact"]["name"]).to eq(@contact_name)
		end

		it "should return header" do
			api_connector = GetContact.new(@token)
			expect(api_connector.headers).to eq({"Authorization"=>"Basic some-token"})
		end

		# it "should return endpoint" do
		# 	api_connector = GetContact.new(@token)

		# 	expect(api_connector.contact_endpoint).to eq(ENV['BASE_URL'] + ENV['GET_CONTACT'] + '?id=')
		# end
	end
end