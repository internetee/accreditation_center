require 'rails_helper'
require_relative "../../support/devise"

RSpec.describe GenerateContactResult do
	login_user

	context "chiecking contacts" do
		before(:each) do
			@response = {
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

		it "should return true if both contacts are true" do
			allow(@api_connector).to receive(:request).and_return(@response)
			allow(@api_connector).to receive(:contact_endpoint).and_return("http://example.api")
			allow(GenerateContactResult).to receive(:check_contact).with(cont_id: "BBAA", is_priv: true).and_return(true)
			allow(GenerateContactResult).to receive(:check_contact).with(cont_id: "AABB", is_priv: false).and_return(true)

			result = GenerateContactResult.checking_data(@hash)
			
			expect(result).to be true
		end

		it "should return false if both contacts are false" do
			allow(@api_connector).to receive(:request).and_return(@response)
			allow(@api_connector).to receive(:contact_endpoint).and_return("http://example.api")
			allow(GenerateContactResult).to receive(:check_contact).with(cont_id: "BBAA", is_priv: true).and_return(false)
			allow(GenerateContactResult).to receive(:check_contact).with(cont_id: "AABB", is_priv: false).and_return(false)

			result = GenerateContactResult.checking_data(@hash)
			
			expect(result).to be false
		end

		it "should return false if priv contact is false and org is true" do
			allow(@api_connector).to receive(:request).and_return(@response)
			allow(@api_connector).to receive(:contact_endpoint).and_return("http://example.api")
			allow(GenerateContactResult).to receive(:check_contact).with(cont_id: "BBAA", is_priv: true).and_return(false)
			allow(GenerateContactResult).to receive(:check_contact).with(cont_id: "AABB", is_priv: false).and_return(true)

			result = GenerateContactResult.checking_data(@hash)
			
			expect(result).to be false
		end

				it "should return false if priv contact is true and org is false" do
			allow(@api_connector).to receive(:request).and_return(@response)
			allow(@api_connector).to receive(:contact_endpoint).and_return("http://example.api")
			allow(GenerateContactResult).to receive(:check_contact).with(cont_id: "BBAA", is_priv: true).and_return(true)
			allow(GenerateContactResult).to receive(:check_contact).with(cont_id: "AABB", is_priv: false).and_return(false)

			result = GenerateContactResult.checking_data(@hash)
			
			expect(result).to be false
		end
	end
end