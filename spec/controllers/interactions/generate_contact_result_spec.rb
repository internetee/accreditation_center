require 'rails_helper'
require_relative "../../support/devise"

RSpec.describe GenerateContactResult do
	login_user

	it "should return result true" do
		response = {
			"code" => 1000
		}

		token = "example-2233"
		api_connector = GetContact.new(token)

		allow(api_connector).to receive(:request).and_return(response)
		allow(api_connector).to receive(:contact_endpoint).and_return("http://example.api")

		result = GenerateContactResult.process(contact_id: "AABB", api_connector: api_connector, action: "contact", user: @user)
		
		expect(result).to be true
	end

	it "should return result false" do
		response = {
			"code" => 2000
		}

		token = "example-2233"
		api_connector = GetContact.new(token)

		allow(api_connector).to receive(:request).and_return(response)
		allow(api_connector).to receive(:contact_endpoint).and_return("http://example.api")

		result = GenerateContactResult.process(contact_id: "AABB", api_connector: api_connector, action: "contact", user: @user)
		
		expect(result).to be false
	end
end