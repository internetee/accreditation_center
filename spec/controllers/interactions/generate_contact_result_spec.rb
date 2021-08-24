require 'rails_helper'
require_relative "../../support/devise"

RSpec.describe GenerateContactResult do
	login_user

	context "valid data" do
		it "checking priv contact should return true" do
			response = {
				"code" => 1000,
				"data" => {
					"name" => "PRIV",
					"email" => "PRIV@eesti.ee",
					"phone" => "+372.51234567",
					"ident" => {
						"type" => "priv",
						"code" => "49708260212"
					}
				}
			}

			token = "example-2233"
			api_connector = GetContact.new(token)

			allow(api_connector).to receive(:request).and_return(response)
			allow(api_connector).to receive(:contact_endpoint).and_return("http://example.api")

			allow(GenerateContactResult).to receive(:check_org_contact).and_return(true)

			hash = {
				org_contact_id: "AABB",
				priv_contact_id: "BBAA",
				api_connector: api_connector,
				action: "contact",
				user: @user,
				priv_name: "PRIV",
				org_name: "ORG"
			}

			result = GenerateContactResult.checking_data(hash)
			
			expect(result).to be true
		end

		it "checking org contact should return true" do
			response = {
				"code" => 1000,
				"data" => {
					"name" => "ORG",
					"email" => "PRIV@eesti.ee",
					"phone" => "+372.51234567",
					"ident" => {
						"type" => "org",
						"code" => "49708260212"
					}
				}
			}

			token = "example-2233"
			api_connector = GetContact.new(token)

			allow(api_connector).to receive(:request).and_return(response)
			allow(api_connector).to receive(:contact_endpoint).and_return("http://example.api")

			allow(GenerateContactResult).to receive(:check_private_contact).and_return(true)

			hash = {
				org_contact_id: "AABB",
				priv_contact_id: "BBAA",
				api_connector: api_connector,
				action: "contact",
				user: @user,
				priv_name: "PRIV",
				org_name: "ORG"
			}

			result = GenerateContactResult.checking_data(hash)
			
			expect(result).to be false
		end
	end

	context "invalid data" do
		before(:each) do
			token = "example-2233"
			@api_connector = GetContact.new(token)

			@hash = {
				org_contact_id: "AABB",
				priv_contact_id: "BBAA",
				api_connector: @api_connector,
				action: "contact",
				user: @user,
				priv_name: "PRIV",
				org_name: "ORG"
			}


		end

		it "response with diffent data for priv should return false" do
			@response = {
				"code" => 1000,
				"data" => {
					"name" => "FAIL",
					"email" => "FAIL@eesti.ee",
					"phone" => "+372.666",
					"ident" => {
						"type" => "priv",
						"code" => "000000"
					}
				}
			}

			allow(@api_connector).to receive(:request).and_return(@response)
			allow(@api_connector).to receive(:contact_endpoint).and_return("http://example.api")

			allow(GenerateContactResult).to receive(:check_org_contact).and_return(true)

			result = GenerateContactResult.checking_data(@hash)
			
			expect(result).to be false
		end

		it "response with diffent data for org should return false" do
			@response = {
				"code" => 1000,
				"data" => {
					"name" => "FAIL",
					"email" => "FAIL@eesti.ee",
					"phone" => "+372.666",
					"ident" => {
						"type" => "org",
						"code" => "000000"
					}
				}
			}

			allow(@api_connector).to receive(:request).and_return(@response)
			allow(@api_connector).to receive(:contact_endpoint).and_return("http://example.api")

			allow(GenerateContactResult).to receive(:check_private_contact).and_return(true)

			result = GenerateContactResult.checking_data(@hash)
			
			expect(result).to be false
		end

		it "response with diffent code should return false" do
			@response = {
				"code" => 1001,
				"data" => {
					"name" => "BBAA",
					"email" => "BBAA@eesti.ee",
					"phone" => "+372.51234567",
					"ident" => {
						"type" => "priv",
						"code" => "49708260212"
					}
				}
			}

			allow(@api_connector).to receive(:request).and_return(@response)
			allow(@api_connector).to receive(:contact_endpoint).and_return("http://example.api")

			allow(GenerateContactResult).to receive(:check_org_contact).and_return(true)

			result = GenerateContactResult.checking_data(@hash)
			
			expect(result).to be false
		end

	end
end