require 'rails_helper'
require_relative "../../../support/devise"

RSpec.describe GenerateContactResult do
	login_user

	context "chiecking contacts" do
		before(:each) do
			@response = {
				"code" => 1000,
				"contact" => {
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

	context "compare data" do
		it "should return true if private data match" do
			response = {
				"code" => 1000,
				"contact" => {
					"name" => "PRIV",
					"email" => "PRIV@eesti.ee",
					"phone" => "+372.51234567",
					"ident" => {
						"type" => "priv",
						"code" => "49708260212"
					}
				}
			}

			result = GenerateContactResult.send(:compare_data_of_contact, response: response, is_priv: true)
	
			expect(result).to be true
		end

		it "should return false if private data doesn't match" do
			response = {
				"code" => 1000,
				"contact" => {
					"name" => "PRIV",
					"email" => "PRIV@findland.fi",
					"phone" => "+372.0066",
					"ident" => {
						"type" => "org",
						"code" => "123456"
					}
				}
			}

			result = GenerateContactResult.send(:compare_data_of_contact, response: response, is_priv: true)
	
			expect(result).to be false
		end

		it "should return true if organization data match" do
			response = {
				"code" => 1000,
				"contact" => {
					"name" => "ORG",
					"email" => "ORG@eesti.ee",
					"phone" => "+372.51200167",
					"ident" => {
						"type" => "org",
						"code" => "12345678"
					}
				}
			}

			result = GenerateContactResult.send(:compare_data_of_contact, response: response, is_priv: false)
	
			expect(result).to be true
		end

		it "should return false if organization data doesn't match" do
			response = {
				"code" => 1000,
				"contact" => {
					"name" => "ORG",
					"email" => "ORG@finland.fi",
					"phone" => "+372.51200000",
					"ident" => {
						"type" => "org",
						"code" => "123451111"
					}
				}
			}

			result = GenerateContactResult.send(:compare_data_of_contact, response: response, is_priv: false)
	
			expect(result).to be false
		end
	end

	context "check contacts" do	
		it "should return true if all results true" do
			response = {
				"code" => "1000",
				"contact" => {
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
			api_connector = double()
			allow(api_connector).to receive(:get_contact).with("AABB").and_return(response)

			hash = {
				api_connector: api_connector,
				priv_contact_id: "AABB",
				org_contact_id: "BBAA",
				action: "contact",
				user: @user,
				priv_name: "John",
				org_name: "Tallinnk"
			}

			allow(GenerateContactResult).to receive(:check_contact).with(cont_id: "AABB", is_priv: true).and_return(true)
			allow(GenerateContactResult).to receive(:check_contact).with(cont_id: "BBAA", is_priv: false).and_return(true)
		
			expect(GenerateContactResult.checking_data(hash)).to be true
		end
	end
end